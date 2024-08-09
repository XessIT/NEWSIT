import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/read_screen/read_screen_bloc.dart';
import '../bloc/read_screen/read_screen_events.dart';
import '../bloc/read_screen/read_screen_state.dart';
import '../bloc/story_page/story_page_bloc.dart';
import '../bloc/story_page/story_page_events.dart';
import '../model/news_model.dart';
import '../model/read_story_model.dart';
import '../repositories/storage.dart';
import '../screens/news_feed.dart';
import '../screens/storyviewpage.dart';
import '../webNews.dart';
import 'custom_appbar.dart';
import 'landing_screen.dart';
import 'newsApi.dart';


class ReadScreen extends StatefulWidget {
  ReadScreen({Key? key}) : super(key: key);

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  late Future<List<News>> _news;
  late ReadScreenBloc _bloc;
  String? token;


  @override
  void initState() {
    super.initState();
    final secureStorageService = SecureStorageService();
    final newsService = NewsService(secureStorageService: secureStorageService);
    _news = newsService.fetchNews(1, 20, 'en'); // Initial fetch
    _bloc = ReadScreenBloc();
    _initializeBloc();
  }

  Future<void> _initializeBloc() async {
    token = await SecureStorageService().readAccessToken();
    print("read token : $token");

    // Now that the token is available, add the FetchNewsCategories event
    _bloc.add(FetchNewsCategories('$token'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            BlocBuilder<ReadScreenBloc, ReadScreenState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is ReadScreenLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ReadScreenLoaded) {
                  return _buildTopNavigationBar(context, state.newsCategories);
                } else if (state is ReadScreenError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return Container();
              },
            ),
            FutureBuilder<List<News>?>(
              future: _news,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load news: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(child: Text('No news available'));
                } else {
                  final newsList = snapshot.data!;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final newsItem = newsList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebNews(),
                            ),
                          );
                        },
                        child: NewsFeed(
                            imageUrl: newsItem.news_card_images?.original_url ?? 'https://via.placeholder.com/150',
                            title: (newsItem.web_content ?? '').isNotEmpty
                                ? (newsItem.web_content ?? '').substring(0, 50) + '...'
                                : 'No content',
                            newsId: newsItem.id ?? '',
                            profiles: (newsItem.profiles ?? []).isNotEmpty
                                ? (newsItem.profiles ?? []).map((p) => p.name ?? 'No name').join(', ')
                                : 'No profiles',
                            tags: (newsItem.tags ?? []).isNotEmpty ? (newsItem.tags ?? []).join(', ') : 'No tags',
                            topics: (newsItem.topics ?? []).isNotEmpty
                                ? (newsItem.topics ?? []).map((t) => t.name ?? 'No name').join(', ')
                                : 'Topics',
                            likeCount: newsItem.like_count ?? 0,
                            saveCount: newsItem.save_count ?? 0

                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar(BuildContext context, List<NewsCategory> categories) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return _buildNavItem(context, category.name, category.images, category.id, categories);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String? imagePath, String id, List<NewsCategory> categories) {
    final category = categories.firstWhere((cat) => cat.id == id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => StoryPageBloc()..add(LoadStories(category)),
              child: StoryPage(category: category),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath != null
                  ? Image.asset(imagePath, fit: BoxFit.cover)
                  : Image.network('https://via.placeholder.com/150', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}

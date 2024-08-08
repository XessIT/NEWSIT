import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/news_model.dart';
import '../repositories/storage.dart';
import '../screens/news_feed.dart';
import '../theme/image_resource.dart';
import '../webNews.dart';
import 'custom_appbar.dart';
import 'landing_screen.dart';
import 'newsApi.dart';
import 'read_navigation_bloc.dart';

class ReadScreen extends StatefulWidget {
  ReadScreen({Key? key}) : super(key: key);

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  late Future<List<News>> _news;

  @override
  void initState() {
    super.initState();
    final secureStorageService = SecureStorageService();
    final newsService = NewsService(secureStorageService: secureStorageService);
    _news = newsService.fetchNews(1, 20, 'en'); // Initial fetch
  }

  final List<Widget> _pages = [
    AllNews(showAppBar: false),
    const Center(child: Text('Top 10 Tamilnadu')),
    const Center(child: Text('Chennai')),
    const Center(child: Text('Coimbatore')),
    const Center(child: Text('Trichy')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildTopNavigationBar(context),
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

  Widget _buildTopNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildNavItem(context, 'Top 10 India', ImageResource.splashlogo, 0),
            _buildNavItem(context, 'Top 10 Tamilnadu', ImageResource.splashlogo, 1),
            _buildNavItem(context, 'Chennai', ImageResource.splashlogo, 2),
            _buildNavItem(context, 'Coimbatore', ImageResource.splashlogo, 3),
            _buildNavItem(context, 'Trichy', ImageResource.splashlogo, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ReadNavigationBloc>(context).add(SelectReadPageEvent(index));
      },
      child: BlocBuilder<ReadNavigationBloc, ReadNavigationState>(
        buildWhen: (previous, current) => previous.selectedIndex != current.selectedIndex,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: state.selectedIndex == index ? Colors.red : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: state.selectedIndex == index ? Colors.red : Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

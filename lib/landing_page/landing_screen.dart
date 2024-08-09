import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/landing_page/read_screen.dart';
import 'package:read/webNews.dart';

import '../bloc/read_screen/read_screen_bloc.dart';
import '../bloc/read_screen/read_screen_events.dart';
import '../model/news_model.dart';
import '../repositories/storage.dart';
import '../screens/menu.dart';
import '../screens/news_feed.dart';
import '../screens/public_report.dart';
import '../screens/reach_form.dart';
import '../screens/storyviewpage.dart';
import 'custom_appbar.dart';
import 'navigation_bloc.dart';
import 'newsApi.dart';
import 'news_bloc.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              title: 'Exit',
              desc: 'Do you want to Exit?',
              width: 400,
              btnOk: ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              btnCancel: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ).show();
            return false;
          },
          child: Stack(
            children: [
              BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  final pages = [
                    ReadScreen(),
                    ReportNewsScreen(),
                    ContactUsPage(),
                  ];
                  return pages[state.selectedIndex];
                },
              ),
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
          
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: BlocBuilder<NavigationBloc, NavigationState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            context,
                            icon: Icons.menu_book_outlined,
                            label: 'Read',
                            index: 0,
                          ),
                          _buildNavItem(
                            context,
                            icon: Icons.collections_bookmark,
                            label: 'Report',
                            index: 1,
                          ),
                          _buildNavItem(
                            context,
                            icon: Icons.area_chart,
                            label: 'Reach',
                            index: 2,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required String label, required int index}) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context).add(SelectPageEvent(index));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: BlocProvider.of<NavigationBloc>(context).state.selectedIndex == index
                ? Colors.blue
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: BlocProvider.of<NavigationBloc>(context).state.selectedIndex == index
                  ? Colors.blue
                  : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}




class AllNews extends StatefulWidget {
  final bool showAppBar;

  const AllNews({Key? key, this.showAppBar = true}) : super(key: key);

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  late Future<List<News>> _news;

  @override
  void initState() {
    super.initState();
    final secureStorageService = SecureStorageService();
    final newsService = NewsService(secureStorageService: secureStorageService);
    _news = newsService.fetchNews(1, 20, 'en'); // Initial fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? BarApp()
          : null,
      body: SafeArea(
        child: FutureBuilder<List<News>?>(
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
                      imageUrl : newsItem.news_card_images?.original_url ?? 'https://via.placeholder.com/150',
                      title: (newsItem.web_content ?? '').isNotEmpty
                          ? (newsItem.web_content ?? '').substring(0, 50) + '...'
                          : 'No content',
                      newsId : newsItem.id ?? '',
                      //description: newsItem.description,
                      profiles: (newsItem.profiles ?? []).isNotEmpty ? (newsItem.profiles ?? []).map((p) => p.name ?? 'No name').join(', ') : 'No profiles',
                      tags: (newsItem.tags ?? []).isNotEmpty ? (newsItem.tags ?? []).join(', ') : 'No tags',
                      topics: (newsItem.topics ?? []).isNotEmpty ? (newsItem.topics ?? []).map((t) => t.name ?? 'No name').join(', ') : 'Topics',
                      likeCount: newsItem.like_count ?? 0,
                      saveCount: newsItem.save_count ?? 0,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


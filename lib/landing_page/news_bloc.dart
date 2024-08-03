import 'package:flutter/material.dart';
import '../repositories/storage.dart';
import 'newsApi.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<dynamic>> _news;
  String _selectedLanguage = 'en'; // default language
  final SecureStorageService _secureStorageService = SecureStorageService();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final newsService = NewsService(secureStorageService: _secureStorageService);
    setState(() {
      _news = newsService.fetchNews(1, 10, _selectedLanguage);
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      _fetchNews();
    });
  }

  Future<void> _refreshNews() async {
    setState(() {
      _isRefreshing = true;
    });
    await _fetchNews();
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _changeLanguage,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'en',
                  child: Text('English'),
                ),
                const PopupMenuItem<String>(
                  value: 'ta',
                  child: Text('Tamil'),
                ),
              ];
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: FutureBuilder<List<dynamic>>(
          future: _news,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("${snapshot.error}");
              return Center(child: Text('Failed to load news: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('No news available'));
            } else {
              final newsList = snapshot.data!;
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final newsItem = newsList[index];
                  return ListTile(
                    leading: newsItem['news_card'] != null && newsItem['news_card']['thumbnail_url'] != null
                        ? Image.network(newsItem['news_card']['thumbnail_url']!, width: 50, height: 50, fit: BoxFit.cover)
                        : null,
                    title: Text(newsItem['title'] ?? 'No Title'),
                    subtitle: Text(newsItem['description'] ?? 'No Description'),
                    isThreeLine: true,
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

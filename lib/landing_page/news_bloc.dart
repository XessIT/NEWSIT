import 'package:flutter/material.dart';
import 'package:read/model/api_response.dart';
import '../model/news_model.dart';
import '../repositories/storage.dart';
import 'newsApi.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<News>?> _news;
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
              print(newsList);
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final newsItem = newsList[index];
                  return ListTile(
                    leading:Image.network(newsItem.news_card_images?.original_url ?? 'https://via.placeholder.com/150') , // Placeholder
                    title: Text(
                      (newsItem.web_content ?? '').isNotEmpty
                          ? (newsItem.web_content ?? '').substring(0, 50) + '...'
                          : 'No content',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsItem.web_content ?? 'No content'),
                        SizedBox(height: 4),
                        Text('Tags: ${(newsItem.tags ?? []).isNotEmpty ? (newsItem.tags ?? []).join(', ') : 'No tags'}'),
                        SizedBox(height: 4),
                        Text('Profiles: ${(newsItem.profiles ?? []).isNotEmpty ? (newsItem.profiles ?? []).map((p) => p.name ?? 'No name').join(', ') : 'No profiles'}'),
                        SizedBox(height: 4),
                        Text('Topics: ${(newsItem.topics ?? []).isNotEmpty ? (newsItem.topics ?? []).map((t) => t.name ?? 'No name').join(', ') : 'No topics'}'),
                      ],
                    ),
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

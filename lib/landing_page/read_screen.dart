import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/landing_page/custom_appbar.dart';

import '../bloc/read_screen/read_screen_bloc.dart';
import '../bloc/read_screen/read_screen_events.dart';
import '../bloc/read_screen/read_screen_state.dart';
import '../bloc/story_page/story_page_bloc.dart';
import '../bloc/story_page/story_page_events.dart';
import '../model/news_model.dart';
import '../screens/storyviewpage.dart';

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  late ReadScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ReadScreenBloc()..add(FetchNewsCategories('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjMxMTQ0MjcsImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.70gv9Li1ZuvSyROEAucgjSLmCm43KTMt8oMcy3aSpo0'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(),
      body: BlocBuilder<ReadScreenBloc, ReadScreenState>(
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

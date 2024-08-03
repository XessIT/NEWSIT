import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/menu.dart';
import '../screens/storyviewpage.dart';
import '../theme/image_resource.dart';
import 'custom_appbar.dart';
import 'landing_screen.dart';
import 'read_navigation_bloc.dart';

class ReadScreen extends StatelessWidget {
  final List<Widget> _pages = [
    const AllNews(showAppBar: false),
    Center(child: Text('Top 10 Tamilnadu')),
    Center(child: Text('Chennai')),
    Center(child: Text('Coimbatore')),
    Center(child: Text('Trichy')),
  ];

  ReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuPage()), // Replace HomePage with your home page widget
          );
        }, icon: Icon(Icons.menu),),
        title:Image.asset(
          'assets/png/newsit2 1.png',
          //height: 100,
        ),
        actions: [CustomAppBar()],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          _buildTopNavigationBar(context),
          Expanded(
            child: BlocBuilder<ReadNavigationBloc, ReadNavigationState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _pages[state.selectedIndex],
                );
              },
            ),
          ),
        ],
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
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StoryPage()),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 80, // Set the width for both image and container
                  height: 100, // Set the height for both image and container
                  decoration: BoxDecoration(
                    color: state.selectedIndex == index ? Colors.red : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Ensure the image fits within the rounded corners
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
                    fontSize: 12, // Adjust the font size as needed
                    color: state.selectedIndex == index ? Colors.red : Colors.black, // Change to yellow for debugging
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/landing_page/read_screen.dart';
import '../screens/menu.dart';
import '../screens/news_feed.dart';
import '../screens/public_report.dart';
import '../screens/reach_form.dart';
import 'custom_appbar.dart';
import 'navigation_bloc.dart';


class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: Stack(
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

  const AllNews({super.key, this.showAppBar = true});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1619356/pexels-photo-1619356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/104827/cat-pet-animal-domestic-104827.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/355564/pexels-photo-355564.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/132037/pexels-photo-132037.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/145939/pexels-photo-145939.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/196647/pexels-photo-196647.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/169573/pexels-photo-169573.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/219943/pexels-photo-219943.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1414457/pexels-photo-1414457.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/333649/pexels-photo-333649.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/35600/road-sun-rays-path.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/196644/pexels-photo-196644.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            );
          },
          icon: Icon(Icons.menu),
        ),
        title:Image.asset(
          'assets/png/newsit2 1.png',
          //height: 100,
        ),
        actions: [CustomAppBar()],
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      )
          : null,
      body: SafeArea(
        child: ListView.builder(
          itemCount: imageUrls.length * 50,
          itemBuilder: (context, index) {
            return NewsFeed(
              imageUrl: imageUrls[index % imageUrls.length],
              // Adjust height if needed
            );
          },
        ),
      ),
    );
  }
}

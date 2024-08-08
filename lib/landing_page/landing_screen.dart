import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/landing_page/read_screen.dart';
import 'package:read/webNews.dart';

import '../bloc/read_screen/read_screen_bloc.dart';
import '../bloc/read_screen/read_screen_events.dart';
import '../screens/menu.dart';
import '../screens/news_feed.dart';
import '../screens/public_report.dart';
import '../screens/reach_form.dart';
import '../screens/storyviewpage.dart';
import 'custom_appbar.dart';
import 'navigation_bloc.dart';
import 'news_bloc.dart';

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
                  BlocProvider(
                    create: (context) => ReadScreenBloc()..add(FetchNewsCategories('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjMxMjA1MjksImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.51wimiQ7Xiv6aR2bFRdHn15wraflAQQf-Hm3lu9lZRU')),
                    child: ReadScreen(),
                  ),
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

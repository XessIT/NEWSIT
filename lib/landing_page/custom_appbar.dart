import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import '../screens/notification.dart';

import '../screens/search.dart';
import 'landing_screen.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isPositiveMode = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: _isPositiveMode,
              onChanged: (value) {
                setState(() {
                  _isPositiveMode = value;
                });
              },
              activeColor: Colors.green,
            ),
            Text(
              _isPositiveMode ? 'Positive Mode' : 'Positive Mode is off',
              style: TextStyle(color: Colors.black, fontSize: 5),
            ),
          ],
        ),
        SizedBox(width: 10),
        CircleIconButton(
          icon: Icons.search,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
        SizedBox(width: 10),
        Stack(
          children: [
            CircleIconButton(
              icon: Icons.notifications,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsScreen()),
                );
              },
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  CircleIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(
          side: BorderSide(color: Colors.grey),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.blue),
        onPressed: onPressed,
      ),
    );
  }
}

class LeadingApp extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBack;

  const LeadingApp({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.displayLarge),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBack ?? () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingScreen()),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

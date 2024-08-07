import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import '../screens/notification.dart';

import '../screens/search.dart';
import 'landing_screen.dart';

class BarApp extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  BarApp({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.menu,size: 30,),
          onPressed: () {
            // Handle menu button press
          },

        ),
      ),
      title: Image.asset(
        'assets/png/newsit2 1.png',
        height: kToolbarHeight - 8, // Adjust the height as necessary
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust the padding as necessary
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Switch(
                value: true, // Set the initial value as necessary
                onChanged: (bool newValue) {
                  // Handle switch change
                },
                activeColor: Colors.green,
              ),
              SizedBox(width: 10), // Space between switch and icons
              _buildCircleIconButton(Icons.search, () {
                // Handle search button press
              }),
              SizedBox(width: 10), // Space between icons
              _buildCircleIconButton(Icons.notifications, () {
                // Handle notifications button press
              }, hasNotification: true),
              SizedBox(width: 10), // Space to the end of the app bar
            ],
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Widget _buildCircleIconButton(IconData icon, VoidCallback onPressed, {bool hasNotification = false}) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200, // Adjust background color if necessary
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
            color: Colors.black, // Adjust icon color if necessary
          ),
        ),
        if (hasNotification)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
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

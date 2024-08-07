import 'package:flutter/material.dart';
import 'package:read/screens/signup.dart';
import 'package:read/screens/welcome.dart';

import '../ui_components/customButton.dart';

class LanguageDesign extends StatefulWidget {
  @override
  _LanguageDesignState createState() => _LanguageDesignState();
}

class _LanguageDesignState extends State<LanguageDesign> {
  int _currentIndex = 0;

  final List<String> images = [
    'assets/png/english.jpeg',
    'assets/png/english-tamil.jpeg',
    'assets/png/english.jpeg',
  ];

  void _onLanguageButtonPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onVerifyButtonPressed() {
    if (_currentIndex == 0) {
      // Handle English-English selection
    } else if (_currentIndex == 1) {
      // Handle English-Tamil selection
    } else if (_currentIndex == 2) {
      // Handle Tamil-Tamil selection
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Select Language",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),

          Positioned(
            top: 150,
            left: 55,
            child: Container(
              width: 300,
              height: 573,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.zero,
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                image: DecorationImage(
                  image: AssetImage(images[_currentIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LanguageButton(
                      label: 'English-English',
                      isSelected: _currentIndex == 0,
                      onTap: () => _onLanguageButtonPressed(0),
                    ),
                    LanguageButton(
                      label: 'English-தமிழ்',
                      isSelected: _currentIndex == 1,
                      onTap: () => _onLanguageButtonPressed(1),
                    ),
                    LanguageButton(
                      label: 'தமிழ்-தமிழ்',
                      isSelected: _currentIndex == 2,
                      onTap: () => _onLanguageButtonPressed(2),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: 'Continue',
                  onPressed: _currentIndex != null
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     SignUpScreen()), // Replace HomePage with your home page widget
                          );
                        }
                      : null,
                  showIconLeft: false, // Change to true to show the left icon
                  showArrowRight:
                      false, // Change to true to show 7402537926the right icon
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  LanguageButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 45,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

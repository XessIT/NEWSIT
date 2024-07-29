import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../landing_page/custom_appbar.dart';
import 'menu.dart';


class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  int _currentIndex = 0;
  final List<String> images = [
    'assets/image1.jpeg',
    'assets/image1.jpeg',
    'assets/image1.jpeg'
  ];
  PageController _pageController = PageController();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentIndex < images.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }

        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  TextEditingController  companyName = TextEditingController();
  bool get _isButtonEnabled {
    return companyName.text.isNotEmpty ;
  }
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Image.asset(
                        //   'assets/image1.jpeg',
                        //   height: 50,
                        // ),
                        Container(
                          width: 43, // Adjust the width and height as needed
                          height: 43,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1), // Circular border
                          ),
                          child: Center(
                            child: Icon(Icons.ac_unit_sharp), // Icon inside the circle
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'NEWSIT',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
        
                    Row(
                      children: [
                        Container(
                          width: 43, // Adjust the width and height as needed
                          height: 43,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1), // Circular border
                          ),
                          child: Center(
                            child: Icon(Icons.translate), // Icon inside the circle
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 43, // Adjust the width and height as needed
                          height: 43,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1), // Circular border
                          ),
                          child: Center(
                            child: Icon(Icons.notifications_none_rounded), // Icon inside the circle
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 43, // Adjust the width and height as needed
                          height: 43,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1), // Circular border
                          ),
                          child: Center(
                            child: Icon(Icons.person_outline_outlined), // Icon inside the circle
                          ),
                        ),
                        // CircleAvatar(
                        //   backgroundImage: AssetImage('assets/image1.jpeg'),
                        // ),
                      ],
                    ),
        
                  ],
                ),*/
                SizedBox(height: 16),
                // Image Carousel
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                                (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text('Reach:', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Company Name", style: TextStyle(fontSize: 15)),
                TextField(
                  controller: companyName,
                  decoration: InputDecoration(
                    hintText: 'Company Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("Phone Number", style: TextStyle(fontSize: 15)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
        
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("Email ID", style: TextStyle(fontSize: 15)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
        
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("Comment", style: TextStyle(fontSize: 15)),
        
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // maxLines: 3,
                ),
                SizedBox(height: 3),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: _isButtonEnabled
                          ? LinearGradient(
                        colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                          : null,
                      color: _isButtonEnabled ? null : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                        // Handle submit button press
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
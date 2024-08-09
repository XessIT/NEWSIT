import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../landing_page/custom_appbar.dart';
import '../repositories/reachApi.dart';
import '../repositories/storage.dart';
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

  bool get _isButtonEnabled {
    return companyNameController.text.isNotEmpty ;
  }
  final ReachApiService _reachApiService = ReachApiService(Dio(), SecureStorageService());
  TextEditingController companyNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Future<void> _handleSubmit() async {
    try {
      final response = await _reachApiService.submitReach(
        company_name: companyNameController.text,
        phone_number: phoneNumberController.text,
        email: emailController.text,
        comment: commentController.text,
      );

      if (response.statusCode == 200) {
        // Handle successful submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission successful!')),
        );
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit data!')),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarApp(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 30),
                      const Text('Reach:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Company Name", style: TextStyle(fontSize: 15)),
                      TextField(
                        controller: companyNameController,
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
                        controller: phoneNumberController,
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
                        controller: emailController,
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
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Comment',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: _isButtonEnabled
                                  ? const LinearGradient(
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
                                _handleSubmit();
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
                              child: const Text(
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
                        ),
                      ),
                      const SizedBox(height: 100),
                      // Add some padding at the bottom
                    ],
                  ),
                ),
              ),
            ),
            // Submit Button should always stay visible at the bottom

          ],
        ),
      ),
    );
  }


}
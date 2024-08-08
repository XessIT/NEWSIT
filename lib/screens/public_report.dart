import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../landing_page/custom_appbar.dart';
import '../theme/image_resource.dart';
import 'NewsListPage.dart';
import 'menu.dart';
import 'news_feed.dart';
import 'notification.dart'; // Import the carousel_slider package

class ReportNewsScreen extends StatefulWidget {
  @override
  _ReportNewsScreenState createState() => _ReportNewsScreenState();
}

class _ReportNewsScreenState extends State<ReportNewsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newsDescriptionController =
  TextEditingController();
  int _newsInProgress = 7;
  int _newsRejected = 7;
  int _newsPublished = 7;
  bool _isButtonEnabled = false;

  void _submitNews() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Logic for submitting news and updating analytics
      });
    }
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState!.validate();
    });
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
        child: Form(
          key: _formKey,
          onChanged: _validateForm,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Report News",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselIntroduction(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Image",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "News Description",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _newsDescriptionController,
                  maxLength: 250,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'News Description',
                    hintText: 'Enter details in about 125 to 250 characters',
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a news description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _validateForm();
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap:(){
                    _isButtonEnabled ? _submitNews : null;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsListPage(),
                      ),
                    );

                  },

                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: _isButtonEnabled
                          ? LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                          : null,
                      color: _isButtonEnabled ? null : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "View your Analytics",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                ViewAnalytics(
                  newsInProgress: _newsInProgress,
                  newsRejected: _newsRejected,
                  newsPublished: _newsPublished,
                ),
                Container(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewAnalytics extends StatelessWidget {
  final int newsInProgress;
  final int newsRejected;
  final int newsPublished;

  ViewAnalytics({
    required this.newsInProgress,
    required this.newsRejected,
    required this.newsPublished,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnalyticsCard(
          title: 'News in progress',
          count: newsInProgress,
          color: Colors.blue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsListPage(),
              ),
            );
            // Your onTap functionality here
            print('Card tapped!');
          },
        ),
        AnalyticsCard(
          title: 'News Rejected',
          count: newsRejected,
          color: Colors.red,
          onTap: () {
            // Your onTap functionality here
            print('Card tapped!');
          },
        ),
        AnalyticsCard(
          title: 'News Published',
          count: newsPublished,
          color: Colors.green,
          onTap: () {
            // Your onTap functionality here
            print('Card tapped!');
          },
        ),
      ],
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;

  AnalyticsCard({
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: color),
            top: BorderSide(color: color),
            bottom: BorderSide(color: color),
            right: BorderSide(
              color: color,
              width: 5.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselIntroduction extends StatelessWidget {
  final List<String> images = [
    ImageResource.splashlogo,
    ImageResource.splashlogo,
    ImageResource.splashlogo,
  ]; // List of image URLs for carousel

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        height: 150,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

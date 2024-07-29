import 'package:flutter/material.dart';
import 'package:read/screens/public_report.dart';


import '../landing_page/custom_appbar.dart';
import '../theme/image_resource.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeadingApp(title:"Search",),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),

              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Topics',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 15.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  TopicChip(label: '#trending'),
                  TopicChip(label: '#plants'),
                  TopicChip(label: '#IPLupdates'),
                  TopicChip(label: '#Sports'),
                  TopicChip(label: '#greenthumb'),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              // Divider(
              //   thickness: 1,
              // ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Web News',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => ReportNewsScreen(),
                      ));
                    },
                    child: Text('View All',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Green thumbs unite: Tips and tricks for a thriving garden',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Text(
                  'March 13, 2024 · 5 min read',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(ImageResource.splashlogo,
                      width: 50, height: 50, fit: BoxFit.cover),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'From seed to bloom: Nurturing a garden from start to finish',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Text(
                  'March 06, 2024 · 2 min read',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(ImageResource.splashlogo,
                      width: 50, height: 50, fit: BoxFit.cover),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 16.0),
              Text(
                'Image',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 150,
                        height: 200,
                        child: Image.asset(ImageResource.splashlogo,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 150,
                        height: 200,
                        child: Image.asset(ImageResource.splashlogo,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 150,
                        height: 200,
                        child: Image.asset(ImageResource.splashlogo,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 150,
                        height: 200,
                        child: Image.asset(ImageResource.splashlogo,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicChip extends StatelessWidget {
  final String label;

  TopicChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Radius for rounded corners
        ),
      ),
    );
  }
}

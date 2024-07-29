import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class NewsItHome extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('NEWSIT'),
          bottom: TabBar(
            indicatorColor: Colors.red, // Set the indicator color to red
            labelColor: Colors.red, // Set the label color of the selected tab to red
            unselectedLabelColor: Colors.grey, // Set the label color of unselected tabs
            tabs: [
              Tab(text: 'SHORT NEWS'),
              Tab(text: 'WEB NEWS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ShortNewsForm(),
            WebNewsForm(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }

}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
        ),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
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
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconSize: 24,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Read',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.area_chart),
                label: 'Reach',
              ),
            ],
            currentIndex: 1,
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}

class ShortNewsForm extends StatelessWidget {
  bool get _isButtonEnabled {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Upload Placeholder
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Icon(Icons.upload_file, size: 40),
                  Text('Upload Image', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // News Details Form

          TextField(
            decoration: InputDecoration(
              labelText: 'Name / Author Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'News Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Source',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Add #hashtags',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 16),

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
          ),
          SizedBox(height: 16),

          // Analytics
          Text('View your Analytics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          AnalyticsItem(label: 'News In-progress', count: 7, color: Colors.blue),
          SizedBox(height: 8),
          AnalyticsItem(label: 'News Rejected', count: 7, color: Colors.red),
          SizedBox(height: 8),
          AnalyticsItem(label: 'News Published', count: 7, color: Colors.green),
        ],
      ),
    );
  }
}
class WebNewsForm extends StatefulWidget {
  @override
  _WebNewsFormState createState() => _WebNewsFormState();
}

class _WebNewsFormState extends State<WebNewsForm> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  bool get _isButtonEnabled {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('News Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Image', style: TextStyle(fontSize: 14)),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: _image == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file, size: 40),
                      Text('Upload Image', style: TextStyle(fontSize: 16)),
                    ],
                  )
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Author Name', style: TextStyle(fontSize: 14)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('News Title', style: TextStyle(fontSize: 14)),
            TextField(
              decoration: InputDecoration(
                hintText: 'News Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('News', style: TextStyle(fontSize: 14)),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'News',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                counterText: '45/350',
                counterStyle: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 16),
            Text('Category', style: TextStyle(fontSize: 14)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Select Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: [
                DropdownMenuItem(value: 'Category 1', child: Text('Category 1')),
                DropdownMenuItem(value: 'Category 2', child: Text('Category 2')),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            Text('Location', style: TextStyle(fontSize: 14)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Select Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: [
                DropdownMenuItem(value: 'Location 1', child: Text('Location 1')),
                DropdownMenuItem(value: 'Location 2', child: Text('Location 2')),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
           // Text('Add #hashtags', style: TextStyle(fontSize: 14)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add #hashtags',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),

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
            ),
            const SizedBox(height: 16),

            // Analytics
            const Text(
              'View your Analytics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            AnalyticsItem(label: 'News In-progress', count: 7, color: Colors.blue),
            SizedBox(height: 8),
            AnalyticsItem(label: 'News Rejected', count: 7, color: Colors.red),
            SizedBox(height: 8),
            AnalyticsItem(label: 'News Published', count: 7, color: Colors.green),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: 'Add News',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   selectedItemColor: Colors.red,
      // ),
    );
  }
}



class AnalyticsItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  AnalyticsItem({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16)),
              Text(count.toString(), style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 64,
            width: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
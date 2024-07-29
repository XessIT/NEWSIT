import 'package:flutter/material.dart';

import 'EditNewsPage.dart';

class NewsListPage extends StatelessWidget {
  final List<String> newsList = [
    "Your news have been News In-progress",
    "Your news have been News In-progress",
    "Your news have been News In-progress",
    "Your news have been News In-progress",
    "Your news have been News In-progress",
    "Your news have been News In-progress",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News In-progress', style: TextStyle(fontSize: 15)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 400,
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Stack(
                  children: [
                    ListTile(
                      leading: Image.network(
                        'https://via.placeholder.com/150',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(newsList[index], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Your news have been Published'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNewsPage(),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 84,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A89E3),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


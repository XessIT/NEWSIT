import 'package:flutter/material.dart';



class WebNewsPage_G extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        //padding: EdgeInsets.all(8.0),
        children: [
          buildNewsCard(),

          // Add more news cards as needed
        ],
      ),
    );
  }

  Widget buildNewsCard() {
    return Container(
      width: double.infinity,
      height: 900,
       // Adjust height as needed
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/bridge.jpg', // Replace with your placeholder asset
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned(
            top: 360, // Adjust position as needed
            left: 0, // Adjust position as needed
            right: 0, // Adjust position as needed
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Added opacity to make text more readable
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), // adjust the value to your liking
                  topLeft: Radius.circular(25), // adjust the value to your liking
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),


                  Text("The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed-The error you're encountering is due to setting height: double.infinity in your Container inside the buildNewsCard method. This causes the Container to take up an infinite height, which is not allowed12345678908765434567890876543q324567890765",

                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sunday, July 2021',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LONDON — ',

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 290, // Adjust position as needed
            left: 35, // Adjust position as needed
            right: 35, // Adjust position as needed
            child: Container(
              height: 180,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.8), // Added opacity to make text more readable
                //color: Colors.white, // Added opacity to make text more readable
                borderRadius: BorderRadius.circular(20)
              ),

              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sunday, 9 May 2021',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Crypto investors should be prepared to lose all their money, BOE governor says',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    //SizedBox(height: 4.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Published By Gowtham"),
                        SizedBox(width:70),
                        IconButton(icon: Icon(Icons.share), onPressed: () {}),
                        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
                      ],
                    ),

                  ],
                              ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}





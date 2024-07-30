import 'dart:ui';
import 'package:flutter/material.dart';

class WebNews extends StatefulWidget {
  const WebNews({Key? key}) : super(key: key);

  @override
  _WebNewsState createState() => _WebNewsState();
}

class _WebNewsState extends State<WebNews> {
  final _sheet = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'), // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // DraggableScrollableSheet
            DraggableScrollableSheet(
              key: _sheet,
              initialChildSize: 0.5,
              maxChildSize: 0.7,
              minChildSize: 0.4,
              expand: true,
              snap: true,
              snapSizes: const [0.6],
              builder: (BuildContext context, ScrollController scrollController) {
                return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: const [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 70),
                              Text(
                                'LONDON — Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey says.',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Digital currencies like bitcoin, ether and even dogecoin have been on a tear this year, reminding some investors of the 2017 crypto bubble which saw bitcoin barrel towards 20,000, only to sink as low as 3,122 a year later.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Transparent BackdropFilter content (above the image and DraggableScrollableSheet)
            Positioned(
              top: 250,
              left: 25,
              right: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.3), // Light blue-grey color
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sunday, 9 May 2021',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Crypto investors should be \nprepared to lose all their money, \nBOE governor says',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w700, color: Colors.black),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Published by Ryan Browne',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Spacer(),
                              Icon(Icons.bookmark_border),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

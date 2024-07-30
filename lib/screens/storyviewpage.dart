// main.dart
import 'package:flutter/material.dart';
import 'package:read/screens/webnews_G.dart';
import 'package:story_view/story_view.dart';
import '../ui_components/customButton.dart';



class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final storyController = StoryController();

  final List<Map<String, String>> worldWonders = [
    {
      'title': 'Taj Mahal',
      'description':
      'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Great Wall of China',
      'description':
      'The Great Wall of China is a series of fortifications that were built across the historical northern borders of China.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Chichen Itza',
      'description':
      'Chichen Itza was a large pre-Columbian city built by the Maya people of the Terminal Classic period.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Christ the Redeemer',
      'description':
      'Christ the Redeemer is an Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Machu Picchu',
      'description':
      'Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Petra',
      'description':
      'Petra is a famous archaeological site in Jordan\'s southwestern desert, dating to around 300 B.C.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
    {
      'title': 'Colosseum',
      'description':
      'The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum.',
      'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = worldWonders.map((wonder) {
      return StoryItem.pageImage(
        url: wonder['imageUrl']!,
        caption: Text(wonder['description']!),
        controller: storyController,
      );
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          StoryView(
            storyItems: storyItems,
            controller: storyController,
            inline: false,
            repeat: false,
            onComplete: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebNewsPage_G(),));
                // Implement the logic for reading the news
              },
              text: 'Read the news',

            ),
          ),
        ],
      ),
    );
  }
}










class Magazine extends StatelessWidget {
  final List<String> magazineCovers = [
    // Add URLs of magazine covers
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magazine Viewer'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: magazineCovers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Magazine_View(
                    storyUrls: magazineCovers,
                    initialStoryIndex: index,
                  ),
                ),
              );
            },
            child: Image.network(
              magazineCovers[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class Magazine_View extends StatelessWidget {
  final List<String> storyUrls;
  final int initialStoryIndex;

  Magazine_View({required this.storyUrls, this.initialStoryIndex = 0});

  @override
  Widget build(BuildContext context) {
    final storyController = StoryController();

    List<StoryItem> storyItems = storyUrls.map((url) {
      return StoryItem.pageImage(
        url: url,
        controller: storyController,
      );
    }).toList();

    return Scaffold(
      body: StoryView(
        storyItems: storyItems,
        controller: storyController,
        repeat: false,
        onStoryShow: (storyItem, index) {
          print("Showing story at index $index");
        },
        onComplete: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}




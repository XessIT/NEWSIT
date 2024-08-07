import 'package:flutter/material.dart';

class SearchProfile extends StatefulWidget {
  const SearchProfile({super.key});

  @override
  _SearchProfileState createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/8/85/Narendra_Modi_2021.jpg",
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Rajendra Modi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "@narendramodi",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "17",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Followers"),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Text(
                      "270",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Following"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Narendra Damodardas Modi born 17 September 1950 is an Indian politician who has served as the 14th prime minister of India since May 2014.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleFollow,
              style: ElevatedButton.styleFrom(
                foregroundColor: isFollowing ? Colors.white : Colors.blue,
                backgroundColor: isFollowing ? Colors.purple : Colors.white,
                side: BorderSide(color: isFollowing ? Colors.purple : Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text(
                isFollowing ? "Unfollow" : "Follow",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Primary"),
                      Tab(text: "Secondary"),
                      Tab(text: "All"),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        buildGridView(),
                        buildGridView(),
                        buildGridView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage("https://via.placeholder.com/150"),
              fit: BoxFit.cover,
            ),
          ),
          height: (index == 0 || index == 3 || index == 6) ? 200 : 100, // Larger size for specific positions
        );
      },
    );
  }
}



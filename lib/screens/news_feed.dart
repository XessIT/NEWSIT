import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bloc/newCard/newsCard_bloc.dart';
import '../bloc/newCard/newsCard_event.dart';
import '../bloc/newCard/newsCard_state.dart';
import '../repositories/likeApi.dart';
import 'SearchProfile.dart';


class NewsFeed extends StatefulWidget {
  final String newsId;
  final String imageUrl;
  final String title;
  final String profiles;
  final String tags;
  final String topics;
  final int likeCount;

  const NewsFeed({
    Key? key,
    required this.newsId,
    required this.imageUrl,
    required this.title,
    required this.profiles,
    required this.tags,
    required this.topics, required this.likeCount,
  }) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  bool isLiked = false; // Track if the news is liked

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    final newsApiService = NewsApiService(
      baseUrl: 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com',
      storage: storage,
    );

    return BlocProvider(
      create: (context) => NewsFeedBloc(newsApiService),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
        child: Container(
          width: 335,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5FC),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(-1, 1),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Color(0x17000000),
                offset: Offset(-3, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(-7, 6),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Color(0x03000000),
                offset: Offset(-12, 12),
                blurRadius: 7,
              ),
              BoxShadow(
                color: Color(0x00000000),
                offset: Offset(-20, 18),
                blurRadius: 7,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SearchProfile()),
                    );
                  },
                  child: Text(
                    widget.topics,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "WAIT AND SEE",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Posted on: 25/02/2024',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Read More',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BlocConsumer<NewsFeedBloc, NewsFeedState>(
                            listener: (context, state) {
                              if (state is NewsFeedLiked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News liked successfully')),
                                );
                              } else if (state is NewsFeedDisliked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News disliked successfully')),
                                );
                              } else if (state is NewsFeedError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: isLiked ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  if (isLiked) {
                                    context.read<NewsFeedBloc>().add(DislikeNewsEvent(widget.newsId));
                                  } else {
                                    context.read<NewsFeedBloc>().add(LikeNewsEvent(widget.newsId));
                                  }
                                  setState(() {
                                    isLiked = !isLiked; // Toggle the liked state
                                  });
                                },
                              );
                            },
                          ),
                           Text('${widget.likeCount}'),
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () {},
                          ),
                          const Text('14'),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {},
                          ),
                          const Text('14'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

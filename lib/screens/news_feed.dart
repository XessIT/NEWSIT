import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/repositories/storage.dart';
import '../bloc/newCard/newsCard_bloc.dart';
import '../bloc/newCard/newsCard_event.dart';
import '../bloc/newCard/newsCard_state.dart';
import '../repositories/likeApi.dart';
import '../repositories/saveApi.dart';
import 'SearchProfile.dart';


class NewsFeed extends StatefulWidget {
  final String newsId;
  final String imageUrl;
  final String title;
  final String profiles;
  final String tags;
  final String topics;
  final int likeCount;
  final int saveCount;

  const NewsFeed({
    Key? key,
    required this.newsId,
    required this.imageUrl,
    required this.title,
    required this.profiles,
    required this.tags,
    required this.topics, required this.likeCount, required this.saveCount,
  }) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  bool isLiked = false;
  bool isSaved = false; // Track if the news is saved

  @override
  Widget build(BuildContext context) {
    final newsApiService = NewsApiService(
      baseUrl: 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com',
      secureStorageService: SecureStorageService(),
    );

    final saveApiService = SaveApiService(
      baseUrl: 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com',
      secureStorageService: SecureStorageService(),
    );

    return BlocProvider(
      create: (context) => NewsCardBloc(newsApiService, saveApiService),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
        child: Container(
          width: 335,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5FC),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          BlocConsumer<NewsCardBloc, NewsCardState>(
                            listener: (context, state) {
                              if (state is NewsFeedLiked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News liked successfully')),
                                );
                              } else if (state is NewsFeedDisliked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News disliked successfully')),
                                );
                              } else if (state is NewsFeedSaved) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News saved successfully')),
                                );
                              } else if (state is NewsFeedUnsaved) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('News unsaved successfully')),
                                );
                              } else if (state is NewsFeedError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: isLiked ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (isLiked) {
                                        context.read<NewsCardBloc>().add(DislikeNewsEvent(widget.newsId));
                                      } else {
                                        context.read<NewsCardBloc>().add(LikeNewsEvent(widget.newsId));
                                      }
                                      setState(() {
                                        isLiked = !isLiked;
                                      });
                                    },
                                  ),
                                  Text('${widget.likeCount}'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.comment,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const Text('14'),
                                  SizedBox(width: 150,),
                                  IconButton(
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: isSaved ? Colors.blue : Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (isSaved) {
                                        context.read<NewsCardBloc>().add(UnsaveNewsEvent(widget.newsId));
                                      } else {
                                        context.read<NewsCardBloc>().add(SaveNewsEvent(widget.newsId));
                                      }
                                      setState(() {
                                        isSaved = !isSaved;
                                      });
                                    },
                                  ),
                                  Text('${widget.saveCount}'),
                                ],
                              );
                            },
                          ),
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



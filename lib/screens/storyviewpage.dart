import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';

import '../bloc/story_page/story_page_bloc.dart';
import '../bloc/story_page/story_page_events.dart';
import '../bloc/story_page/story_page_state.dart';
import '../model/read_story_model.dart';
import '../ui_components/customButton.dart';

class StoryPage extends StatelessWidget {
  final NewsCategory category;

  StoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryPageBloc()..add(LoadStories(category)),
      child: Scaffold(
        body: BlocBuilder<StoryPageBloc, StoryPageState>(
          builder: (context, state) {
            if (state is StoryPageLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StoryPageLoaded) {
              return Stack(
                children: [
                  StoryView(
                    storyItems: state.storyItems,
                    controller: StoryController(),
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
                        Navigator.pop(context);
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
                        // Implement the logic for reading the news
                      },
                      text: 'Read the news',
                    ),
                  ),
                ],
              );
            } else if (state is StoryPageError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

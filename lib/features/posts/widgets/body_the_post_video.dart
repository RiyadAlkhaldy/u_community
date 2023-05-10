import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import '../../video/orientation/portrait_player_widget.dart';
import '../../../models/post_model.dart';
import '../repository/repository_posts.dart';
import '../screens/view_post_screen.dart';

class BodyThePostVideo extends StatelessWidget {
  final int index;
  final Posts? post;
  BodyThePostVideo({
    Key? key,
    required this.index,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return InkWell(
            // onTap: () => print('Like post'),
            // onTap: () => print("push video"),
            onDoubleTap: () {
              ref.read(postStateProvider.notifier).state = post;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewPostScreen(
                    post: post!,
                  ),
                ),
              );
            },
            child: LimitedBox(
              maxWidth: double.infinity,
              maxHeight: 400,
              child: PortraitPlayerWidget(
                post: post,
              ),
            ));
      },
    );
  }
}

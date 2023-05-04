// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../repository/repository_posts.dart';
import '../screens/view_post_screen.dart';

class BodyThePostImage extends StatelessWidget {
  final Posts post;

  BodyThePostImage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return InkWell(
          onDoubleTap: () => print('Like post'),
          onTap: () {
            ref.read(postStateProvider.notifier).state = post;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewPostScreen(
                  post: post,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            width: double.infinity,
            height: 380.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 5),
                  blurRadius: 2.0,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(post.url!),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}

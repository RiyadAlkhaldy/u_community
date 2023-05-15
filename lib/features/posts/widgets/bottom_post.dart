import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post_model.dart';
import '../repository/repository_colloge_posts.dart';
import '../repository/repository_posts.dart';
import '../repository/repository_section_posts.dart';
import '../screens/layout/post_layout.dart';
import '../screens/view_post_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget bottomPost(BuildContext context, Posts post) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //!likePosts
                    Consumer(
                      builder: (context, ref, child) => IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: post.amILike > 0 ? Colors.red : Colors.black,
                          ),
                          iconSize: 30.0,
                          onPressed: () {
                            print('Like post');
                            if (ref.watch(currentIndexPagePost) == 0) {
                              ref
                                  .read(postsProvider.notifier)
                                  .addLikeOrUndo(post, context);
                            } else if (ref.watch(currentIndexPagePost) == 1) {
                              ref
                                  .read(collogePostsProvider.notifier)
                                  .addLikeOrUndo(post, context);
                            } else {
                              ref
                                  .read(sectionPostsProvider.notifier)
                                  .addLikeOrUndo(post, context);
                            }
                            // ref.read(postStateProvider.notifier).state = post;
                          }),
                    ),
                    Text(
                      post.likeCount.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Row(
                  children: <Widget>[
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return IconButton(
                          icon: Icon(Icons.chat),
                          iconSize: 30.0,
                          onPressed: () {
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
                        );
                      },
                    ),
                    Text(
                      post.commentCount.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            // IconButton(
            //   icon: const Icon(
            //     Icons.bookmark_border,
            //   ),
            //   iconSize: 30.0,
            //   onPressed: () => print('Save post'),
            // ),
          ],
        ),
        // time age
        Text(
            timeago.format(
              DateTime.parse(post.createdAt),
            ),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.5),
                )),
      ],
    ),
  );
}

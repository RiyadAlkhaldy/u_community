import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../repository/repository_posts.dart';
import 'body_the_post_image.dart';
import 'body_the_post_text.dart';
import 'body_the_post_video.dart';
import 'bottom_post.dart';
import 'package:timeago/timeago.dart' as timeago;

class buildPost extends StatelessWidget {
  final int index;
  final Posts? post;
  BuildContext contextl;
  buildPost({
    Key? key,
    required this.index,
    required this.contextl,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('post =     ${post!.url}');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        // !
        // height: 560.0,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  //! Header The Post Widget
                  // if (post!.type ==)
                  HeaderThePost(
                    post: post!,
                  ),

                  if (post!.type == 2) BodyThePostImage(post: post!),
                  if (post!.type == 3)
                    BodyThePostVideo(
                      index: index,
                      post: post,
                    ),
                  if (post!.type == 1)
                    BodyThePostText(
                      post: post!,
                    ),
                  BottomPost(
                    context,
                    post!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderThePost extends ConsumerWidget {
  final Posts post;
  HeaderThePost({
    Key? key,
    required this.post,
  }) : super(key: key);
  // DateTime? timeage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListTile(
          trailing: Text(
            post.colloge.name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 20, color: Colors.black),
          ),
          leading: post.section != null
              ? Text(post.section!.name,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ))
              : Text(''),
        ),
        ListTile(
          // contentPadding: EdgeInsets.symmetric(horizontal: 5),

          leading: LefePostHeader(context, ref),
          // leading: PostProfileImage(),
          title: Text(
            post.user.name,
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 20, color: Colors.black),
          ),

          subtitle: Text(post.content,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                  )),
          trailing: PostProfileImage(),
        ),
      ],
    );
  }

  IconButton LefePostHeader(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        showDialog(
          useRootNavigator: false,
          context: context,
          builder: (context) {
            return Dialog(
              child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shrinkWrap: true,
                  children: ['Delete', 'Modify']
                      .map(
                        (e) => InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(115, 138, 222, 245),
                                    offset: Offset(0, 5),
                                    blurRadius: 15.0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Text(e),
                            ),
                            onTap: () {
                              ref
                                  .read(postsProvider.notifier)
                                  .deletePost(post.id);
                              Navigator.of(context).pop();
                            }),
                      )
                      .toList()),
            );
          },
        );
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  Container PostProfileImage() {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: CircleAvatar(
        child: ClipOval(
          child: post.user.img.isEmpty
              ? Image.asset('assets/images/user1.png')
              : Image(
                  height: 50.0,
                  width: 50.0,
                  image: NetworkImage(post.url!),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

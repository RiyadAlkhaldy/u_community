import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/core/utils/utils.dart';

import '../../../core/utils/loader.dart';
import '../../auth/repository/auth_repository.dart';
import '../../../models/post_model.dart';
import '../../posts/repository/repository_colloge_posts.dart';
import '../../setting/screens/setting_screen.dart';
import '../../../models/comment_model.dart';
import '../repository/repository_comments.dart';
import '../../posts/repository/repository_posts.dart';
import '../../posts/repository/repository_section_posts.dart';
import '../../posts/screens/layout/post_layout.dart';

Widget buildComment(int index, BuildContext context, Comments comment) {
  return Consumer(
    builder: (_, WidgetRef ref, __) {
      var img = comment.img;
      if (comment.img == null) {
        img = ref.watch(gitImageurlTemp);
      }
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
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
              child: CachedNetworkImage(
                // imageUrl: widget.imagePath,
                imageUrl: img!,
                placeholder: (context, img) => const Loader(),
                fit: BoxFit.cover,
                width: 108,
                height: 108,
                // child: InkWell(onTap: onClicked),
                // ),
              ),

              //  Image(
              //   height: 50.0,
              //   width: 50.0,
              //   image: AssetImage(comments[index].authorImageUrl),
              //   fit: BoxFit.cover,
              // ),
            )),
          ),
          title: comment.name!.isEmpty
              ? Text('the name prop is null',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
              : Text(comment.name!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
          subtitle: Text(
            comment.comment,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontSize: 16),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.grey,
              onPressed: () async {
                // print('delete////');
                final user = await ref.watch(getUserProvider);
                if (int.parse(user['id']) == comment.userId ||
                    int.parse(user['type']) == 3) {
                  // ignore: use_build_context_synchronously
                  await showModalBottomAcceptDelete(
                    context,
                    comment,
                    ref,
                  );
                } else {
                  showSnackBar(
                      context: context,
                      content:
                          'لايمكنك جذف التعليق لانك ليس لديك صلاحية عليه أو لأنك لست صحاب التعليق ');
                }
              }),
        ),
      );
    },
  );
}

Future<dynamic> showModalBottomAcceptDelete(
    BuildContext context, Comments comment, WidgetRef ref) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
              color: const Color(0xFF2e3253).withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonLogoutOurCancel(
                  'Cancel',
                  () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 50,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final posts = ref.watch(postStateProvider);

                    return StatefulBuilder(
                      builder: (context, setState) => buttonLogoutOurCancel(
                        'OK',
                        () async {
                          try {
                            ref
                                .read(commentsProvider.notifier)
                                .deleteComment(comment.id);
                            int pagePostType = ref.watch(currentIndexPagePost);
                            if (pagePostType == 0) {
                              // final currentPost = ref.watch(postStateProvider);
                              // currentPost!.copyWith(
                              //     commentCount: currentPost.commentCount - 1);
                              ;
                              // ref
                              //     .read(postsProvider.notifier)
                              //     .updatePost(currentPost);
                              // ref.read(postStateProvider.notifier).state =
                              //     currentPost;
                              ref
                                  .read(postsProvider.notifier)
                                  .updateNumberTheComments(posts!, -1);
                              ref.read(postStateProvider.notifier).state =
                                  posts.copyWith(
                                      commentCount: posts.commentCount - 1);
                            } else if (pagePostType == 1) {
// final collogePostStateProvider = StateProvider<Posts?>((ref) => null);

                              ref
                                  .read(collogePostsProvider.notifier)
                                  .updateNumberTheComments(posts!, -1);
                              ref.read(postStateProvider.notifier).state =
                                  posts.copyWith(
                                      commentCount: posts.commentCount - 1);
                            } else {
                              ref
                                  .read(sectionPostsProvider.notifier)
                                  .updateNumberTheComments(posts!, -1);
                              ref.read(postStateProvider.notifier).state =
                                  posts.copyWith(
                                      commentCount: posts.commentCount - 1);
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      });
}

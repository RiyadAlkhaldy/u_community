import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/core/enums/user_enum.dart';
import 'package:u_community/core/utils/utils.dart';
import '../../../core/utils/loader.dart';
import '../../../main.dart';
import '../../../mobile_layout_screen.dart';
import '../../auth/repository/auth_repository.dart';
import '../../posts/repository/repository_colloge_posts.dart';
import '../../setting/screens/setting_screen.dart';
import '../../../models/comment_model.dart';
import '../repository/repository_comments.dart';
import '../../posts/repository/repository_posts.dart';
import '../../posts/repository/repository_section_posts.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildComment(int index, BuildContext context, Comment comment) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
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
            child: comment.user!.img!.isNotEmpty
                ? CachedNetworkImage(
                    // imageUrl: widget.imagePath,
                    imageUrl: comment.user!.img!,
                    placeholder: (context, img) => const Loader(),
                    errorWidget: (context, url, error) =>
                        CachedNetworkImage(imageUrl: url),
                    fit: BoxFit.cover,
                    width: 108,
                    height: 108,
                    // child: InkWell(onTap: onClicked),
                    // ),
                  )
                : Image.asset(
                    'assets/images/user1.png',
                    width: 108,
                    height: 108,
                  ),
          )),
        ),
        title: comment.user!.name.isEmpty
            ? Text('the name prop is null',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18))
            : Text(comment.user!.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              comment.comment!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
            // parse time created comment
            Text(
                timeago.format(
                  DateTime.parse(comment.createdAt!),
                ),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.5),
                    )),
          ],
        ),
        trailing: Consumer(
          builder: (ctx, ref, child) {
            return int.parse(ref.watch(
                        dataUserAuthentecationProvider)![UserEnum.id.type]) ==
                    comment.userId
                ? IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    color: Colors.grey,
                    onPressed: () async {
                      // print('delete////');
                      final user =
                          await ref.watch(getUserProviderfromSharedPrefernces);
                      if (int.parse(user['id']) == comment.userId ||
                          int.parse(user['type']) == 3) {
                        // ignore: use_build_context_synchronously
                        await showModalBottomAcceptDelete(
                          context,
                          comment,
                          ref,
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showSnackBar(
                            context: context,
                            content:
                                'لايمكنك جذف التعليق لانك ليس لديك صلاحية عليه أو لأنك لست صحاب التعليق ');
                      }
                    })
                : const Text('');
          },
        )),
  );
}

Future<dynamic> showModalBottomAcceptDelete(
    BuildContext context, Comment comment, WidgetRef ref) {
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
                                .deleteComment(comment.id!);
                            int pagePostType =
                                ref.watch(currentIndexTabBarPagePost);
                            if (pagePostType == 0) {
                              // final currentPost = ref.watch(postStateProvider);
                              // currentPost!.copyWith(
                              //     commentCount: currentPost.commentCount - 1);
                              // ;
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

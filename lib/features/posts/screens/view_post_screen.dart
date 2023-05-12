import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/loader.dart';
import '../../user/repository/repository_user.dart';
import '../../video/orientation/portrait_landscape_player_page.dart';
import '../../../models/post_model.dart';
import '../../comments/repository/repository_comments.dart';
import '../repository/repository_colloge_posts.dart';
import '../repository/repository_posts.dart';
import '../repository/repository_section_posts.dart';
import '../../comments/widgets/build_comment.dart';
import '../widgets/build_post.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgets/view_post_text_screen.dart';
import 'layout/post_layout.dart';

class ViewPostScreen extends ConsumerStatefulWidget {
  static const String routeName = "view-post-screen";
  final Posts post;

  ViewPostScreen({required this.post});

  @override
  ConsumerState<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends ConsumerState<ViewPostScreen> {
  bool dataLoaded = false;
  bool inital = true;
  TextEditingController addCommentController = TextEditingController();
  // Comments varComment ;
  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postStateProvider);

    if (inital == true) {
      ref
          .watch(commentsProvider.notifier)
          .getAllComments(widget.post.id)
          .then((value) {
        setState(() {
          dataLoaded = true;
          inital = false;
        });
      });
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEDF0F6),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40.0),
                width: double.infinity,
                // height: 600.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          //! view header the post
                          HeaderThePost(
                            post: widget.post,
                            amIInviewSinglePost: true,
                          ),
                          if (widget.post.type == 2)
                            ContentViewPostScreen(post: widget.post),
                          if (widget.post.type == 1)
                            ViewPostText(
                              post: widget.post,
                            ),
                          if (widget.post.type == 3)
                            LimitedBox(
                                maxWidth: double.infinity,
                                maxHeight: 400,
                                child: PortraitLandscapePlayerPage(
                                  post: widget.post,
                                  index: 1,
                                )),

                          Bottom_Post(context, posts!, ref),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              // !this for build comments
              Container(
                  width: double.infinity,
                  // height: 600.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: dataLoaded == true
                      ? Consumer(
                          builder: (_, WidgetRef reff, __) {
                            return Column(
                                children: reff
                                    .watch(commentsProvider.notifier)
                                    .state
                                    .map((comment) =>
                                        buildComment(0, context, comment))
                                    .toList());
                          },
                        )
                      : const Loader()
                  // buildComment(1,context,null),
                  )
            ],
          ),
        ),
        //! this for add comment
        bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 100.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -2),
                  blurRadius: 6.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                controller: addCommentController,
                decoration: InputDec(posts),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration InputDec(Posts post) => InputDecoration(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        hintText: 'Add a comment',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black45),
        prefixIcon: Container(
          margin: const EdgeInsets.all(4.0),
          width: 48.0,
          height: 48.0,
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
              child: ref.watch(getUserProviderProfile).when(
                    data: (data) {
                      if (data!.img == null) {
                        return CachedNetworkImage(
                          // imageUrl: widget.imagePath,
                          imageUrl: ref.watch(gitImageurlTemp),
                          placeholder: (context, img) => const Loader(),
                          fit: BoxFit.cover,
                          width: 108,
                          height: 108,
                          // child: InkWell(onTap: onClicked),
                          // ),
                        );
                      } else {
                        return CachedNetworkImage(
                          // imageUrl: widget.imagePath,
                          imageUrl: data!.img!,
                          placeholder: (context, img) => const Loader(),
                          fit: BoxFit.cover,
                          width: 108,
                          height: 108,
                          // child: InkWell(onTap: onClicked),
                          // ),
                        );
                      }
                      // ref.read(getProfile.notifier).state = data;
                    },
                    error: (error, stackTrace) => const Text('error'),
                    loading: () => const Loader(),
                  ),
              //  widget.post.user.img!.isEmpty
              //     ? Image.asset('assets/images/user1.png')
              //     : Image(
              //         height: 48.0,
              //         width: 48.0,
              //         image: NetworkImage(widget.post.user.img!),
              //         fit: BoxFit.cover,
              //       ),
            ),
          ),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 4.0),
          width: 70.0,
          child: Consumer(
            builder: (_, WidgetRef reff, __) {
              return MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: const Color(0xFF23B66F),
                onPressed: () async {
                  print('Post comment');
                  if (addCommentController.text.trim().isNotEmpty) {
                    reff.read(commentsProvider.notifier).addComment(
                        comment: addCommentController.text.trim().toString(),
                        post_id: post.id);
                    reff
                        .read(postsProvider.notifier)
                        .updateNumberTheComments(post, 1);
                    addCommentController.clear();
                    reff.read(postStateProvider.notifier).state =
                        post.copyWith(commentCount: post.commentCount + 1);
                    ref.invalidate(allcommentsProvider(post.id));
                  }
                },
                child: const Icon(
                  Icons.send,
                  size: 25.0,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      );
}

class ContentViewPostScreen extends ConsumerWidget {
  ContentViewPostScreen({
    super.key,
    required this.post,
  });

  final Posts post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postStateProvider);

    return InkWell(
      onDoubleTap: () => print('Like post'),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 400.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 5),
              blurRadius: 8.0,
            ),
          ],
          // image: DecorationImage(
          //   image: NetworkImage(posts!.url!),
          //   fit: BoxFit.fitWidth,
          // ),
        ),
        child: CachedNetworkImage(
          imageUrl: post.url!,
          placeholder: (context, url) => const Loader(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HeaderViewPostScreen extends ConsumerWidget {
  HeaderViewPostScreen({
    super.key,
    required this.post,
  });

  final Posts post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postStateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
                  child: posts!.user.img == null
                      ? CachedNetworkImage(
                          imageUrl: ref.watch(gitImageurlTemp),
                          height: 50.0,
                          width: 50.0,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          height: 50.0,
                          width: 50.0,
                          image: NetworkImage(posts.user.img!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            title: Text(
              post.content!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: post.content == null ? null : Text(post.content!),
            trailing: IconButton(
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          const BoxShadow(
                                            color: Color.fromARGB(
                                                115, 138, 222, 245),
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
                                      // deletePost(
                                      //   widget.snap['postId']
                                      //       .toString(),
                                      // );
                                      // remove the dialog box
                                      Navigator.of(context).pop();
                                    }),
                              )
                              .toList()),
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ),
      ],
    );
  }
}

Widget Bottom_Post(BuildContext context, Posts post, [WidgetRef? ref]) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    //!likePosts
                    IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: post.amILike > 0 ? Colors.red : Colors.black,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          print('Like post');
                          final amILike = post.amILike;
                          final numberLikes = post.likeCount;
                          if (ref!.watch(currentIndexPagePost) == 0) {
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

                          // ref
                          //     .read(postsProvider.notifier)
                          //     .addLikeOrUndo(post, context);
                          ref.read(postStateProvider.notifier).state =
                              post.copyWith(
                                  amILike: amILike == 0 ? 1 : 0,
                                  likeCount: amILike == 0
                                      ? numberLikes + 1
                                      : numberLikes - 1);
                          // final p = ref.watch(postStateProvider);
                          // ref.read(postsProvider.notifier).updatePost(p!);
                        }),
                    Text(
                      ref!
                          .watch(postStateProvider.notifier)
                          .state!
                          .likeCount
                          .toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat),
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewPostScreen(
                              post: post,
                            ),
                          ),
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
            IconButton(
              icon: const Icon(
                Icons.bookmark_border,
              ),
              iconSize: 30.0,
              onPressed: () => print('Save post'),
            ),
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

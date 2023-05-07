import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../controller/posts_controlller.dart';
import '../../../core/utils/loader.dart';
import '../models/post_model.dart';
import '../repository/repository_posts.dart';
import '../widgets/build_post.dart';

class PostScreen extends ConsumerStatefulWidget {
  PostScreen({
    super.key,
  });

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

var checkposts;

class _PostScreenState extends ConsumerState<PostScreen> {
  @override
  void initState() async {
    await ref.read(postsProvider.notifier).getAllPosts;
    final p = ref.read(postsProvider.notifier).state;
    print(p);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    final postss = ref.watch(allPostsProvider);

    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            PostHeader(),
            Container(
              width: double.infinity,
              height: 100.0,
              child: ListView(
                  scrollDirection: Axis.horizontal, children: [NewWidget()]),
            ), //
            // ref.watch(getAllPostsProvider).when(
            postss.when(
              data: (data) {
                // print('length of the data ${data.length}');
                return Column(
                    children: posts
                        .map((p) => buildPost(
                              index: 0,
                              contextl: context,
                              post: p,
                            ))
                        .toList()

                    // childCount: data.length,
                    );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => Loader(),
            ),

            // Consumer(
            //   builder: (context, ref, child) {
            //     final pos = ref.watch(getAllPostsProvider);
            //     return pos.when(
            //       data: (data) => Column(
            //           children: data
            //               .map((p) => buildPost(
            //                     index: 0,
            //                     contextl: context,
            //                     post: p,
            //                   ))
            //               .toList()

            //           // childCount: data.length,
            //           ),
            //       error: (error, stackTrace) => Text("error"),
            //       loading: () => const Loader(),
            //     );
            //   },
            // ),
          ]),

          // ],
        ),
      ],
    );
  }

  Widget PostHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Instagram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 32.0,
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.live_tv),
                iconSize: 30.0,
                onPressed: () => print('IGTV'),
              ),
              SizedBox(width: 16.0),
              Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 30.0,
                  onPressed: () => print('Direct Messages'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
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
          child: Image(
            height: 60.0,
            width: 60.0,
            image: AssetImage(stories[1]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

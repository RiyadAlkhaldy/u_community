import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../controller/posts_controlller.dart';
import '../../../core/utils/loader.dart';
import '../../../models/post_model.dart';
import '../repository/repository_posts.dart';
import '../widgets/build_post.dart';
import 'layout/post_layout.dart';

class AllPostScreen extends ConsumerStatefulWidget {
  AllPostScreen({
    super.key,
  });

  @override
  ConsumerState<AllPostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<AllPostScreen> {
  // @override
  // void initState() async {
  //   // await ref.read(postsProvider.notifier).getAllPosts;
  //   // final p = ref.read(postsProvider.notifier).state;
  //   // print(p);

  //   super.initState();
  // }

  bool dataLoaded = false;
  bool inital = true;

  @override
  Widget build(BuildContext context) {
    // final posts =
    @override
    void initState() {
      // TODO: implement initState
      ref.read(currentIndexPagePost.notifier).state = 0;
      super.initState();
    }

    if (inital == true) {
      ref.watch(postsProvider.notifier).getAllPosts.then((value) {
        setState(() {
          dataLoaded = true;
          inital = false;
        });
      });
    }
    // final postss = ref.watch(postsProvider);

    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            dataLoaded == true
                ? Column(
                    children: ref
                        .watch(postsProvider)
                        .map((p) => buildPost(
                              index: 0,
                              contextl: context,
                              post: p,
                            ))
                        .toList()

                    // childCount: data.length,
                    )
                : Loader(),
            // postss.when
          ]),

          // ],
        ),
      ],
    );
  }
}

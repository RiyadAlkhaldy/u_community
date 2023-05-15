import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/loader.dart';
import '../repository/repository_section_posts.dart';
import '../widgets/build_post.dart';
import 'layout/post_layout.dart';

class AllSectionPostsScreen extends ConsumerStatefulWidget {
    AllSectionPostsScreen({
    super.key,
  });

  @override
  ConsumerState<AllSectionPostsScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<AllSectionPostsScreen> {
  bool dataLoaded = false;
  bool inital = true;
  @override
  void initState() {
    ref.read(currentIndexPagePost.notifier).state = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final posts =
    if (inital == true) {
      ref.watch(sectionPostsProvider.notifier).getAllSectionPosts.then((value) {
        setState(() {
          dataLoaded = true;
          inital = false;
        });
      });
    }

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
                        .watch(sectionPostsProvider)
                        .map((p) => buildPost(
                              index: 0,
                              contextl: context,
                              post: p,
                            ))
                        .toList())
                : Loader(),
            // postss.when
          ]),

          // ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/loader.dart';
import '../models/post_model.dart';
import '../repository/repository_section_posts.dart';
import '../widgets/build_post.dart';

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
            // PostHeader(),
            // Container(
            //   width: double.infinity,
            //   height: 100.0,
            //   child: ListView(
            //       scrollDirection: Axis.horizontal, children: [NewWidget()]),
            // ),
            dataLoaded == true
                ? Column(
                    children: ref
                        .watch(sectionPostsProvider)
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

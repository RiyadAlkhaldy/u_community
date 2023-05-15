import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../controller/posts_controlller.dart';
import '../../../core/utils/loader.dart';
import '../../../models/post_model.dart';
import '../repository/repository_colloge_posts.dart';
import '../widgets/build_post.dart';
import 'layout/post_layout.dart';
// import '../repository/repository_posts.dart';

class AllCollogePostsScreen extends ConsumerStatefulWidget {
  AllCollogePostsScreen({
    super.key,
  });

  @override
  ConsumerState<AllCollogePostsScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<AllCollogePostsScreen> {
  bool dataLoaded = false;
  bool inital = true;
  @override
  void initState() {
    ref.read(currentIndexPagePost.notifier).state = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final posts =
    if (inital == true) {
      ref.watch(collogePostsProvider.notifier).getAllCollogePosts.then((value) {
        setState(() {
          dataLoaded = true;
          inital = false;
        });
      });
    }
    // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // Future<SharedPreferences> prefs = _prefs;
    // SharedPreferences.getInstance().then((user) async {
    //   await user.clear();
    //   // myuser[UserEnum.token.type] = user.getString(UserEnum.token.type);
    // });
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
                        .watch(collogePostsProvider)
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

class NewWidget extends ConsumerStatefulWidget {
  NewWidget({
    super.key,
  });

  @override
  ConsumerState<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends ConsumerState<NewWidget> {
  bool initail = true;
  Map<String, dynamic>? user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
      ],
    );
  }
}

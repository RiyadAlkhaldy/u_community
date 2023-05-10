// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/models/user_response_auth.dart';
import '../../../core/utils/loader.dart';
import '../../posts/widgets/build_post.dart';
import '../repository/repository_get_user_by_id.dart';
import '../repository/repository_user.dart';
import '../repository/repository_user_posts.dart';
import '../widgets/profile_image_widget.dart' as profile;
import 'view_any_user_screen.dart';

final getProfile = StateProvider<User?>((ref) => null);

class UserProfileScreen extends ConsumerStatefulWidget {
  final int id;
  const UserProfileScreen({Key? key, required this.id}) : super(key: key);
  static const String routeName = 'user-profile-screen';

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  bool dataLoaded = false;
  bool inital = true;
  // var userMap;
  @override
  Widget build(BuildContext context) {
    if (inital == true) {
      ref.watch(userPostsProvider.notifier).getAllPosts.then((value) async {
        // await ref.watch(getUserProvider).then((value) async => userMap = value);

        setState(() {
          dataLoaded = true;
          inital = false;
          print('eqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
        });
      });
    }

    final height = MediaQuery.of(context).size.height / 3;
    print(MediaQuery.of(context).size);
    print('height' + height.toString());
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // user.then((value) {
          //   return
          // }),
          SliverAppBarCustom(
            height: height,
            context: context,
            // user: data!,
          ),

          SliverList(
              delegate:
                  SliverChildListDelegate([ProfileDetials(id: widget.id)])),
          SliverList(
            delegate: SliverChildListDelegate([
              dataLoaded
                  ? Column(
                      children: ref
                          .watch(userPostsProvider)
                          .map((p) => buildPost(
                                index: 0,
                                contextl: context,
                                post: p,
                              ))
                          .toList()

                      // childCount: data.length,
                      )
                  : const Loader(),
              // postss.when
            ]),
          )
        ],
      ),
    );
  }
}

Widget SliverAppBarCustom({
  required double height,
  required BuildContext context,
  // User? user,
}) {
  final String imageUrl =
      "https://img.freepik.com/free-photo/female-student-with-books-paperworks_1258-48204.jpg?w=1380&t=st=1671753820~exp=1671754420~hmac=5846bac8c4fd4ebceecca71a8eda1cd494b92c9aba4c07ea4a78d88de7abc454";
  return SliverAppBar(
    stretch: true,
    centerTitle: true,
    // leading: Icon(Icons.menu),
    expandedHeight: height - 13,
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: [
        StretchMode.blurBackground,
      ],
      title: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Expanded(child: Container()),
            Positioned(
              bottom: -10,
              child: profile.ProfileImageWidget(
                  imagePath: imageUrl, onClicked: () {}),
            ),
          ]),
      centerTitle: true,
      background: Container(
        child: Image.asset('assets/images/andalus.png'),
      ),
    ),
    //show the appar when I was in down the list
    //عرض العنوان اللي فوق او الصور وانا اسفل القائمة بمجرد السحب
    floating: true,
    //غدم اختفاء الشريط اللعلوي كامل ويبقى العنوان ظاهر
    // pinned: true,
  );
}

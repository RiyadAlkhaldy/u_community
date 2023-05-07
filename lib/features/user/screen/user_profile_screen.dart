// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/features/auth/models/user_response.dart';
import '../../../core/error/error.dart';
import '../../../core/utils/loader.dart';
import '../../posts/repository/repository_posts.dart';
import '../../posts/screens/all_colloge_posts_screen.dart';
import '../../posts/widgets/build_post.dart';
import '../models/user_post_model.dart';
import '../repository/repository_user_posts.dart';
import '../widgets/profile_image_widget.dart';

final getProfile = StateProvider<User?>((ref) => null);

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static const String routeName = 'user-profile-screen';

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  bool dataLoaded = false;
  bool inital = true;
  @override
  Widget build(BuildContext context) {
    if (inital == true) {
      ref.watch(userPostsProvider.notifier).getAllPosts.then((value) async {
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
            delegate: SliverChildListDelegate([
              // PostHeader(),
              // Container(
              //   width: double.infinity,
              //   height: 100.0,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [NewWidget()],
              //   ),
              // ), //

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

// class SliverListt extends StatelessWidget {
//   const SliverListt({
//     Key? key,
//     required this.listPostMode,
//   }) : super(key: key);

//   final AsyncValue<List<UserPostModel>> listPostMode;

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: listPostMode.when(
//         data: (data) {
//           return SliverChildBuilderDelegate(
//             (context, index) {
//               return index % 2 == 0
//                   ? buildPost(index: 1, contextl: context)
//                   :
//                   // height: 100,

//                   buildPost(index: 0, contextl: context);
//             },
//             childCount: data.length,
//           );
//         },
//         error: (error, stackTrace) {
//           return SliverChildListDelegate([ErrorScreen(error: "error")]);
//         },
//         loading: () => SliverChildListDelegate([Loader()]),
//       ),
//     );
//   }
// }

class ProfileDetials extends StatelessWidget {
  final User data;
  const ProfileDetials({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          CustomContainer(
            context: context,
            child: Text(
              data.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Colloge:",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              data.collogeId.toString(),
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            VerticalDivider(),
            Text(
              "Department:",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              data.sectionId.toString(),
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "level:",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              data.level.toString().isEmpty ? 'level' : data.level.toString(),
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            VerticalDivider(),
            Text(
              "Address",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            SizedBox(
              width: 5,
            ),
          ]),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  Container CustomContainer(
      {required BuildContext context, required Widget child}) {
    return Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 2,
            offset: Offset(1, 1),
          )
        ],
        border: Border.all(
            // color: Colors.white60,
            ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: child,
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
              child: ProfileImageWidget(imagePath: imageUrl, onClicked: () {}),
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

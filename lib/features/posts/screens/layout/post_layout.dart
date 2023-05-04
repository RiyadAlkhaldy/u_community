import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../auth/repository/auth_repository.dart';
import '../../../auth/repository/laravel_echo.dart';
import '../all_colloge_posts_screen.dart';
import '../all_post_screen.dart';
import '../all_section_posts_screen.dart';

class PostLayout extends ConsumerStatefulWidget {
  PostLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<PostLayout> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<PostLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  //! notifications firebase
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // MyWebsocketAndPusher echo = MyWebsocketAndPusher();

  void testEcho() async {
    // final channel = WebSocketChannel.connect(
    //   Uri.parse('ws://10.0.2.2/api/broadcasting/auth'),
    // );
    // // channel.stream.asBroadcastStream()
    // channel.stream.listen((event) {
    //   print('hellllllllllllllllllllllllllllllllllll $event');
    // });
    // await ref.watch(getUserProvider).then((value) async {
    //   print(value[UserEnum.name.type]);
    //   await LaravelEcho.init(token: '${value[UserEnum.token.type]}');
    //   // LaravelEcho.instance.disconnect();
    // });
    // LaravelEcho.instance.connect();
    // LaravelEcho.instance.e ;

    // await LaravelEcho.instance
    //     .channel('post.notification')
    //     .listen('RealtimePosts', (e) async {
    //   print(
    //       'I listen to hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${e.toString()}');
    // });
    // var x =LaravelEcho.pusherEvent(channelName: '.post.added', eventName: 'RealtimePosts');

    // .subscribed((callback) {
    //   print('hellllllllllllllllllllllllllllllllllll $callback');
    // });
    // LaravelEcho.instance.broadcaster

    // await LaravelEcho.instance.channel('.post.added').listen("RealtimePosts",
    //     (callback) {
    //   print('hellllllllllllllllllllllllllllllllllll $callback');
    // });

    // LaravelEcho.instance.channel('.post.added').listenForWhisper(
    //     'RealtimePosts',
    //     (e) => {
    //           Println(
    //               'hellllllllllllllllllllllllllllllllllllhellllllllllllllllllllllllllllllllllll${e.toString()}')
    //         });
    //   try {
    //     // await  echo.options;
    //     await echo.pusher;
    //     // echo.connect;
    //     echo.onConnectionStateChange;
    //     echo.onConnectionError;
    //     await echo.bind;

    //     echo.channel;
    //   } catch (e) {
    //     print(e);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    testEcho();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: AppBarr(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  backgroundColor: appBarColor,
                  floating: true,
                  snap: true,
                  pinned: true,
                  title: AppBarr(),
                  bottom: TabBarr(),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: tabBarController,
            children: [
              AllPostScreen(),
              AllCollogePostsScreen(),
              AllSectionPostsScreen(),
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButtonWidget(tabBarController: tabBarController),
      ),
    );
  }

  Widget AppBarr() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5),
      // decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'University Communty',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  TabBar TabBarr() {
    return TabBar(
      controller: tabBarController,
      indicatorColor: tabColor,
      indicatorWeight: 4,
      labelColor: tabColor,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      tabs: const [
        Tab(
          text: 'All Posts',
        ),
        Tab(
          text: 'Colloge Posts',
        ),
        Tab(
          text: 'Section Posts',
        ),
      ],
    );
  }
}

//! floating Action Button Widget
class FloatingActionButtonWidget extends StatelessWidget {
  FloatingActionButtonWidget({
    Key? key,
    required this.tabBarController,
  }) : super(key: key);

  final TabController tabBarController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (tabBarController.index == 0) {
          // Navigator.pushNamed(context, SelectContactsScreen.routeName);
        } else {
          File? pickedImage = await pickImageFromGallery(context);
          if (pickedImage != null) {
            // Navigator.pushNamed(
            //   context,
            //   ConfirmStatusScreen.routeName,
            //   arguments: pickedImage,
            // );
          }
        }
      },
      backgroundColor: tabColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

//! popup menu buttom widget
// class PopupMenuButtomWidget extends StatelessWidget {
//   const PopupMenuButtomWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       icon: const Icon(
//         Icons.more_vert,
//         color: Colors.grey,
//       ),
//       itemBuilder: (context) => [
//         PopupMenuItem(
//           child: const Text(
//             'Create Group',
//           ),
//           // onTap: () => Future(
//           //   () => Navigator.pushNamed(context, UserProfileScreen.routeName),
//           // ),
//         )
//       ],
//     );
//   }
// }


//  AppBar AppBarr() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: appBarColor,
//       centerTitle: false,
//       title: const Text(
//         'University Communty',
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.grey,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.search, color: Colors.grey),
//           onPressed: () {},
//         ),
//         PopupMenuButtomWidget(),
//       ],
//       // title: TabBarr(),
//       // bottom: TabBarr(),
//     );
//   }
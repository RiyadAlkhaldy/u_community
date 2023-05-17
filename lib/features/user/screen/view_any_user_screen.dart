// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/features/posts/models/post_model_pagentation.dart';
import '../../../core/utils/loader.dart';
import '../../posts/widgets/build_post.dart';
import '../repository/repository_get_user_by_id.dart';
import '../repository/repository_user_posts _by_id.dart';

final getProfile = StateProvider<User?>((ref) => null);

class ViewAnyUserScreen extends ConsumerStatefulWidget {
  final User users;

  const ViewAnyUserScreen({Key? key, required this.users}) : super(key: key);
  static const String routeName = 'user-any-user-screen';

  @override
  ConsumerState<ViewAnyUserScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<ViewAnyUserScreen> {
  bool dataLoaded = false;
  bool inital = true;
  @override
  Widget build(BuildContext context) {
    if (inital == true) {
      ref.read(getUserIDFromUIProvider.notifier).state = widget.users.id;

      ref
          .watch(userPostsByIdRepository.notifier)
          .getAllPosts(widget.users.id)
          .then((value) async {
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
            dataLoaded ? ProfileDetials(id: widget.users.id) : Container()
          ])),
          SliverList(
            delegate: SliverChildListDelegate([
              dataLoaded
                  ? Column(
                      children: ref
                          .watch(userPostsByIdRepository)
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

class ProfileDetials extends ConsumerStatefulWidget {
  final int id;

  const ProfileDetials({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<ProfileDetials> createState() => _ProfileDetialsState();
}

class _ProfileDetialsState extends ConsumerState<ProfileDetials> {
  bool initail = true;
  // User? user;
  bool dataloaded = false;

  @override
  Widget build(BuildContext context) {
    if (initail == true) {
      initail = false;
      // ref.watch(getUserByIdProvider(widget.id)).then((value) {
      //   print('my User user USer User $value');
      // });

      // ref
      //     .watch(userModelProvider.notifier)
      //     .getUserById(widget.id)
      //     .then((value) async {
      //   setState(() {
      //     print(value);
      //     print(ref.watch(userModelProvider));

      //     user = value;

      //     dataloaded == true;
      //     initail = false;
      //   });
      // });
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ref.watch(getUserByIdProvider).when(
              data: (data) {
                print(
                    'ddddddddddddddddddddddddddddddddddddddddddddddddddddtaattttttttttttttttaaaaaaaaaaaaaaaaa$data');
                return Column(
                  children: [
                    CustomContainer(
                      context: context,
                      child: Text(
                        data!.name.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const VerticalDivider(
                      thickness: 10,
                      width: 5,
                      // color: Colors.white,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      data.colloge != null
                          ? Text(
                              data.colloge!.name,
                              style: Theme.of(context).textTheme.titleSmall!,
                            )
                          : Text(''),
                      const SizedBox(
                        width: 5,
                      ),
                      data.section != null
                          ? Text(
                              data.section!.name,
                              style: Theme.of(context).textTheme.titleSmall!,
                            )
                          : const Text(''),
                      const VerticalDivider(),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Email:   ${data.email}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '',
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
                // ref.read(getProfile.notifier).state = data;
              },
              error: (error, stackTrace) => Text('$error'),
              loading: () => Loader(),
            ));
  }

  Container CustomContainer(
      {required BuildContext context, required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: const [
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
}) {
  return SliverAppBar(
    stretch: true,
    centerTitle: true,
    // leading: Icon(Icons.menu),
    expandedHeight: height - 13,
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: const [
        StretchMode.blurBackground,
      ],
      title: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Expanded(child: Container()),
            Positioned(
              bottom: -10,
              child: ProfileImageTheUser(onClicked: () {}),
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

class ProfileImageTheUser extends ConsumerStatefulWidget {
  final bool isEdit;
  final void Function()? onClicked;

  ProfileImageTheUser({
    Key? key,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  ConsumerState<ProfileImageTheUser> createState() =>
      _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends ConsumerState<ProfileImageTheUser> {
  // bool initail = true;
  // User? user;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
                child: buildEditIcon(color),
                onTap: () async {
                  // final upload = ref.read(uploadProfileImageprovider);
                  // await upload.pickFiles(type: FileType.image);
                  // await upload.upload(
                  //     content: 'no data',
                  //     type: 2,
                  //     urlCompelete: 'user/upload-profile-image/');
                  // ref.refresh(getUserProviderProfile);

                  // setState(() {});
                }),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return buildCircle(
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: ref.watch(userModelProvider).when(
                  data: (data) {
                    if (data!.img!.isEmpty) {
                      return Image.asset(
                        'assets/images/user1.png',
                        width: 108,
                        height: 108,
                      );
                      // return CachedNetworkImage(
                      //   // imageUrl: widget.imagePath,
                      //   imageUrl: ref.watch(gitImageurlTemp),
                      //   placeholder: (context, img) => const Loader(),
                      //   fit: BoxFit.cover,
                      //   width: 108,
                      //   height: 108,
                      //   // child: InkWell(onTap: onClicked),
                      //   // ),
                      // );
                    } else {
                      return CachedNetworkImage(
                        // imageUrl: widget.imagePath,
                        imageUrl: data.img!,
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
                  loading: () => Loader(),
                ),
          ),
        ),
        all: 1,
        color: Colors.white);
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 2,
        child: buildCircle(
          color: color,
          all: 3,
          child: Icon(
            widget.isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

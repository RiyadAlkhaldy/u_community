import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/loader.dart';
import '../repository/repository_user.dart';
import '../repository/upload_file.dart';

class ProfileImageWidget extends ConsumerStatefulWidget {
  final String imagePath;
  final bool isEdit;
  final void Function()? onClicked;

  ProfileImageWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  ConsumerState<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends ConsumerState<ProfileImageWidget> {
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
                  final upload = ref.read(uploadProfileImageprovider);
                  await upload.pickFiles(type: FileType.image);
                  await upload.upload(
                      content: 'no data',
                      type: 2,
                      urlCompelete: 'user/upload-profile-image/');
                  setState(() {});
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
            child: ref.watch(getUserProviderProfile).when(
                  data: (data) {
                    // ref.read(getProfile.notifier).state = data;
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

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 200, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

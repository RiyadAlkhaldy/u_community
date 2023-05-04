// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../posts/models/post_model.dart';
import 'video_player_fullscreen_widget.dart';

 

class PortraitPlayerWidget extends StatefulWidget {
  final Posts? post;
  final FileType? type;
  final File? file;

  PortraitPlayerWidget({
    Key? key,
    this.post,
    this.type,
    this.file,
  }) : super(key: key);

  @override
  _PortraitPlayerWidgetState createState() => _PortraitPlayerWidgetState();
}

class _PortraitPlayerWidgetState extends State<PortraitPlayerWidget> {
  late VideoPlayerController controller;
  final v1 =
      "https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761";
  @override
  void initState() {
    super.initState();

    if (widget.file != null) {
      controller = VideoPlayerController.file(widget.file!)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.pause());
    } else {
      controller = VideoPlayerController.network(widget.post!.url!)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.pause());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        // height: controller.value.size.height,
        height: double.infinity,
        child: VideoPlayerFullscreenWidget(controller: controller),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 5),
              blurRadius: 8.0,
            ),
          ],
        ),
        // margin: EdgeInsets.all(10.0),
        width: double.infinity,
      );
}

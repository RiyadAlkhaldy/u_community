// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../posts/models/post_model.dart';
import 'video_player_both_widget.dart'; 

class PortraitLandscapePlayerPage extends StatefulWidget {
  final int index;
  final Posts? post;
  const PortraitLandscapePlayerPage({
    Key? key,
    required this.index,
    this.post,
  }) : super(key: key);

  @override
  _PortraitLandscapePlayerPageState createState() =>
      _PortraitLandscapePlayerPageState();
}

class _PortraitLandscapePlayerPageState
    extends State<PortraitLandscapePlayerPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.post!.url!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.pause());
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // appBar: AppBar(toolbarHeight: 0),
      // body:
      VideoPlayerBothWidget(controller: controller);
}

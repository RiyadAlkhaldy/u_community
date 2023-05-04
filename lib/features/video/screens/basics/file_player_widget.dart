import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/floating_action_button_widget.dart';
import '../../widgets/video_player_widget.dart';

// import '../other/floating_action_button_widget.dart';
// import '../video_player_widget.dart';

class FilePlayerWidget extends StatefulWidget {
  const FilePlayerWidget({super.key});

  @override
  _FilePlayerWidgetState createState() => _FilePlayerWidgetState();
}

class _FilePlayerWidgetState extends State<FilePlayerWidget> {
  final File file = File(
      '/data/user/0/com.example.video_master/cache/file_picker/big_buck_bunny_720p_10mb.mp4');
  String video =
      "https://player.vimeo.com/external/201962441.hd.mp4?s=d5e09fbd67593c9796cfba4d273bfca4d8a828f9&profile_id=174&oauth2_token_id=57447761";
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    if (file.existsSync()) {
      controller = VideoPlayerController.network(video)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.play());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            VideoPlayerWidget(controller: controller),
            buildAddButton(),
          ],
        ),
      );

  Widget buildAddButton() => Container(
        padding: EdgeInsets.all(32),
        child: FloatingActionButtonWidgett(
          onPressed: () async {
            final file = await pickVideoFile();
            if (file == null) return;

            controller = VideoPlayerController.file(file)
              ..addListener(() => setState(() {}))
              ..setLooping(true)
              ..initialize().then((_) {
                controller.play();
                setState(() {});
              });
          },
        ),
      );

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path!);
  }
}

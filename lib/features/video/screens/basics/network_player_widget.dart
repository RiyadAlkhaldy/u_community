import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/floating_action_button_widget.dart';
import '../../widgets/video_player_widget.dart';

// import '../../main.dart';
// import '../other/floating_action_button_widget.dart';
// import '../other/textfield_widget.dart';
// import '../video_player_widget.dart';
final urlLandscapeVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4';
final urlPortraitVideo =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
final urlYoutubeVideo = 'https://youtube.com/watch?v=HSAa9yi0OMA';

class NetworkPlayerWidget extends StatefulWidget {
  const NetworkPlayerWidget({super.key});

  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  final textController = TextEditingController(text: urlLandscapeVideo);
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(textController.text)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            VideoPlayerWidget(controller: controller),
            buildTextField(),
          ],
        ),
      );

  Widget buildTextField() => Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            // Expanded(
            //   child: TextFieldWidget(
            //     controller: textController,
            //     hintText: 'Enter Video Url',
            //   ),
            // ),
            const SizedBox(width: 12),
            FloatingActionButtonWidgett(
              onPressed: () {
                setState(() {});
                // if (textController.text.trim().isEmpty) return;
              },
            ),
          ],
        ),
      );
}

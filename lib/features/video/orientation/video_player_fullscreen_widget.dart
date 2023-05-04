import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/basic_overlay_widget.dart';

// import '../basic_overlay_widget.dart';

Widget VideoPlayerFullscreenWidget(
    {required VideoPlayerController controller}) {
 
  return Container(
      alignment: Alignment.topCenter,
      child: controller != null && controller.value.isInitialized
          ? buildVideo(controller: controller)
          : Center(
              child: CircularProgressIndicator(
                  // color: Colors.blue,
                  )));
}

Widget buildVideo({required VideoPlayerController controller}) => Stack(
      fit: StackFit.expand,
      children: <Widget>[
        buildVideoPlayer(controller: controller),
        BasicOverlayWidget(controller: controller),
      ],
    );

Widget buildVideoPlayer({required VideoPlayerController controller}) =>
    buildFullScreen(
      controller: controller,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );

Widget buildFullScreen({
  required VideoPlayerController controller,
  required Widget child,
}) {
  final size = controller.value.size;
  final width = size.width;
  final height = size.height;

  return FittedBox(
    fit: BoxFit.contain,
    child: SizedBox(
      width: width,
      height: height,
      child: child,
    ),
  );
}

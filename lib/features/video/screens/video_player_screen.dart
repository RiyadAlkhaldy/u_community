// import 'package:flutter/material.dart';

// import 'package:untitled/features/video/models/video.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// int currentIndex = 0;
// late VideoPlayerController _controller;
// _playVideo({int index = 0, bool init = false}) {
//   if (index < 0 || index >= videoes.length) return;
//   _controller = VideoPlayerController.network(videoes[currentIndex].url)..addListener(() {
//   } );
// }
// //  dispose
// // @override
// // void initState() {
// //   super.initState();
// //   _playVideo(init: true);
// // }
 

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//               child: ListView.builder(
//             itemCount: videoes.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: Image.network(
//                         videoes[index].thumbnail,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 25,
//                     ),
//                     Text(videoes[index].name),
//                   ],
//                 ),
//               );
//             },
//           )),
//         ],
//       ),
//     );
//   }
// }

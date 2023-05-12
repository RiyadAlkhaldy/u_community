import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/posts/screens/upload_file_screen.dart';
import '../../features/posts/screens/upload_text_screen copy.dart';
import 'show_modal_bottom_sheet_post.dart';

class BottomNavigationBarr extends StatelessWidget {
  Function(int)? onTap;
  int currentIndex = 0;

  BottomNavigationBarr({
    Key? key,
    required this.onTap,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.black87.withOpacity(0.5),
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'others',
            // backgroundColor: Colors.white,
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person_outline,
          //     size: 25.0,
          //     color: Colors.grey,
          //   ),
          //   label: 'label',
          // ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: const Color(0xFF23B66F),
                onPressed: () {
                  showModalBottomSheetStudent(context);
                },
                child: const Icon(
                  Icons.add,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            label: '',
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.favorite_border,
          //     size: 25.0,
          //     color: Colors.grey,
          //   ),
          //   label: 'lebel',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25.0,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}

Future<dynamic> showModalBottomSheetStudent(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
              color: const Color(0xFF2e3253).withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  backgroundcolor: Colors.blue,
                  // AppColors.mainColor,
                  text: "Video",
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, UploadFileScreen.routeName,
                        arguments: {"type": FileType.video});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  backgroundcolor: Colors.blue,
                  // AppColors.mainColor,
                  text: "Photo",
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, UploadFileScreen.routeName,
                        arguments: {"type": FileType.image});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  backgroundcolor: Colors.blue,
                  // AppColors.mainColor,
                  text: "text",
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UploadTextScreen.routeName,
                    );
                  },
                )
              ],
            ),
          ),
        );
      });
}

// Future<dynamic> showModalBottomSheetAdmin(BuildContext context) {
//   return showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (_) {
//         return Container(
//           height: 250,
//           decoration: BoxDecoration(
//               color: const Color(0xFF2e3253).withOpacity(0.4),
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ButtonWidget(
//                   backgroundcolor: Colors.blue,
//                   // AppColors.mainColor,
//                   text: "Video",
//                   textColor: Colors.white,
//                   onTap: () {
//                     Navigator.pushNamed(context, UploadFileScreen.routeName,
//                         arguments: {"type": FileType.video});
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ButtonWidget(
//                   backgroundcolor: Colors.blue,
//                   // AppColors.mainColor,
//                   text: "Photo",
//                   textColor: Colors.white,
//                   onTap: () {
//                     Navigator.pushNamed(context, UploadFileScreen.routeName,
//                         arguments: {"type": FileType.image});
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ButtonWidget(
//                   backgroundcolor: Colors.blue,
//                   // AppColors.mainColor,
//                   text: "text",
//                   textColor: Colors.white,
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       UploadTextScreen.routeName,
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         );
//       });
// }

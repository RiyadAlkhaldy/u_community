import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'core/error/error.dart';
import 'features/auth/Screens/login.dart';
import 'features/auth/Screens/registration.dart';
import 'features/auth/screens/student_register.dart';
import 'features/posts/screens/upload_file_screen.dart';
import 'features/posts/screens/upload_text_screen copy.dart';
import 'features/setting/screens/teachers_registerations_screen.dart';
import 'features/user/screen/user_profile_screen.dart';
import 'main.dart';
import 'mobile_layout_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case UserProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>const UserProfileScreen(),
      );
    case Login.routeName:
      return MaterialPageRoute(
        builder: (context) => const Login(),
      );
    case Registration.routeName:
      return MaterialPageRoute(
        builder: (context) => const Registration(),
      );
    case StudentRegister.routeName:
      return MaterialPageRoute(
        builder: (context) => const StudentRegister(),
      );
    case MobileLayoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => MobileLayoutScreen(),
        
      );
    case UploadFileScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final type = arguments['type'] as FileType;
      return MaterialPageRoute(
        builder: (context) => UploadFileScreen(type: type),
      );
    case UploadTextScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => UploadTextScreen(),
      );
    case MyApp.routeName:
      return MaterialPageRoute(
        builder: (context) => MyApp(),
      );
       case TeacherRegisterations.routeName:
      return MaterialPageRoute(
        builder: (context) =>const TeacherRegisterations(),
      );
    // case MobileChatScreen.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;
    //   final name = arguments['name'];
    //   final uid = arguments['uid'];
    //   final isGroupChat = arguments['isGroupChat'];
    //   final profilePic = arguments['profilePic'];
    //   return MaterialPageRoute(
    //     builder: (context) => MobileChatScreen(
    //       name: name,
    //       uid: uid,
    //       isGroupChat: false,
    //       profilePic: profilePic  ,
    //     ),
    //   );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}

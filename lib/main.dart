import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_community/themes.dart';

import 'core/enums/user_enum.dart';
import 'features/auth/Screens/launch.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/setting/screens/header_setting_screen.dart';
import 'mobile_layout_screen.dart';
import 'route.dart';

final dataUserAuthentecationProvider =
    StateProvider<Map<String, dynamic>?>((ref) {
  return null;
});
// 563492ad6f917000010000013d24e4038ca942559b31b58c298d1c40
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AwesomeNotifications().initialize(
  //     null,
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           playSound: true,
  //           channelShowBadge: true,
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupkey: 'basic_channel_group',
  //           channelGroupName: 'Basic group')
  //     ],
  //     debug: true);
  // FlutterDownloader.initialize(
  //   debug: true,
  // );
  await Settings.init(cacheProvider: SharePreferenceCache());
  // final auth = AuthRepository();
  // auth.websok();
  print('hi');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  static const String routeName = 'my-app';
  MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

// @override
// void initState() async {
//   await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   });
//   // TODO: implement initState
//   // super.initState();
// }

class _MyAppState extends ConsumerState<MyApp> {
  final isDarkModes = Settings.getValue<bool>(HeaderSettingScreen.keyDarkMode,
      defaultValue: true);

  String? token = null;
  bool initial = true;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // print('initial =================== $initial');

    if (initial == true) {
      SharedPreferences.getInstance().then((value) async {
        //!this for clear all dara in SharedPreferences .
        // value.clear();

        final userId = value.getString('id');
        token = value.getString('token');
        if (userId != null && userId.isNotEmpty) {
          await ref.watch(getUserProvider).then((value) {
            ref.read(dataUserAuthentecationProvider.notifier).state = value;
          });
        }
        if (kDebugMode) {
          print(UserEnum.token.type);
          print(token);
          print('tttttttttttttttt ${value.getString(UserEnum.name.type)}');
          print('tttttttttttttttt ${value.getString(UserEnum.id.type)}');
        }
        initial = false;
        setState(() {});
      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ValueChangeObserver<bool>(
          cacheKey: HeaderSettingScreen.keyDarkMode,
          // initTheme: MyThemes.darkTheme,
          defaultValue: isDarkModes!,
          builder: (contex, isDarkMode, _) => MaterialApp(
                onGenerateRoute: (initialRoute) => generateRoute(initialRoute),

                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: isDarkMode ? MyThemes.darkTheme : MyThemes.darkTheme,
                // home: SettingScreen(),
                home:
                    token == null ? const StartScreen() : MobileLayoutScreen(),
              ));
    }
  }
}

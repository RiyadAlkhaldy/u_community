import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:u_community/features/auth/repository/auth_repository.dart';
import 'package:u_community/features/setting/screens/user_accounnt.dart';
import '../widgets/reed_back.dart';
import '../widgets/icon_widget.dart';
import 'account_setting_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final switchList = false;
  static const keyDarkMode = 'key-dark-mode';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(
            height: 22,
          ),
          const UserAccount(),
          const AccountSettingScreen(),
          const SizedBox(
            height: 32,
          ),
          SettingsGroup(title: "GENERAL", children: [
            buildLogout(context),
            buildDeleteAccount(),
          ]),
          const SizedBox(
            height: 32,
          ),
          SettingsGroup(title: "Feedback", children: [
            buildNotificationTeachersRegisteraions(context: context),
            buildReportBug(context: context),
            buildSendFeedback(context: context),
          ]),
        ],
      ),
    );
  }
}

Widget buildLogout(context) => SimpleSettingsTile(
      title: "Logout",
      leading: const IconWidget(icon: Icons.logout, color: Color(0xFF642ef3)),
      onTap: () async {
        showModalBottomAcceptLogout(context);
      },
    );

Future<dynamic> showModalBottomAcceptLogout(BuildContext context) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonLogoutOurCancel(
                  'Cancel',
                  () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 50,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return StatefulBuilder(
                      builder: (context, setState) => buttonLogoutOurCancel(
                        'OK',
                        () async {
                          await ref.read(authProvider).logout(context: context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      });
}

InkWell buttonLogoutOurCancel(String text, void Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: text == 'OK' ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

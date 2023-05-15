import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:u_community/features/auth/repository/auth_repository.dart';
import 'package:u_community/features/setting/screens/user_accounnt.dart';
import '../../../core/enums/user_enum.dart';
import '../../../main.dart';
import '../widgets/reed_back.dart';
import '../widgets/icon_widget.dart';
import 'account_setting_screen.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
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
          // const AccountSettingScreen(),
          const SizedBox(
            height: 32,
          ),
          SettingsGroup(title: "GENERAL", children: [
            buildResetEmail(context),
            buildResetPassword(context),
            buildLogout(context),
          ]),
          const SizedBox(
            height: 32,
          ),
          // if()
          if (int.parse(ref.watch(
                  dataUserAuthentecationProvider)![UserEnum.typeUser.type]) <=
              4)
            SettingsGroup(title: "others", children: [
              buildNotificationTeachersRegisteraions(context: context),
              // buildReportBug(context: context),
            ]),
          // if()
          // SettingsGroup(title: "Feedback", children: [
          //   buildNotificationTeachersRegisteraions(context: context),
          //   buildReportBug(context: context),
          //   buildSendFeedback(context: context),
          // ]),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Are sure , Do you want to logout ?',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
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
                              await ref
                                  .read(authProvider)
                                  .logout(context: context);
                            },
                          ),
                        );
                      },
                    ),
                  ],
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

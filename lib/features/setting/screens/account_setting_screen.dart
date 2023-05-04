import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../widgets/icon_widget.dart';
class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});
  static const KeyLanguage = "key-language";
  static const KeyLocation = "key-location";
  static const KeyPassword = "key-password";
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Account Settings",
      subtitle: 'privacy, security, Languages',
      leading: IconWidget(
        icon: Icons.settings,
        color: Colors.blue,
      ),
      onTap: () {
        // switchList = darkMode;
      },
      child: SettingsScreen(
        title: 'Account Settings',
        children: [
          buildLanguage(),
          buildLocation(),
          buildPassword(),
          buildPrivacy(),
          buildSecurity(),
          buildAccountInfo(),
        ],
      ),
    );
    const Placeholder();
  }
}

Widget buildPrivacy() => SimpleSettingsTile(
      title: "Privacy",
      subtitle: '',
      // child: Container(),
      leading: IconWidget(
        icon: Icons.lock_outline,
        color: Colors.blue,
      ),
      onTap: () {
        // switchList = darkMode;
      },
    );
Widget buildSecurity() => SimpleSettingsTile(
      title: "Privacy",
      subtitle: '',
      // child: Container(),
      leading: IconWidget(
        icon: Icons.security,
        color: Colors.red,
      ),
      onTap: () {
        // switchList = darkMode;
      },
    );
Widget buildAccountInfo() => SimpleSettingsTile(
      title: "Account info",
      subtitle: '',
      // child: Container(),
      leading: IconWidget(
        icon: Icons.text_snippet,
        color: Colors.blue,
      ),
      onTap: () {
        // switchList = darkMode;
      },
    );
Widget buildLanguage() => DropDownSettingsTile<int>(
      title: 'Language',
      settingKey: AccountSettingScreen.KeyLanguage,
      values: <int, String>{
        1: "Arbic",
        2: 'English',
        3: 'Roshin',
        4: 'French',
        5: 'Chinese',
        6: 'Spanish',
      },
      selected: 1,
      onChange: (value) {
        debugPrint('key-dropdown-email-view: $value');
      },
    );

Widget buildLocation() => TextInputSettingsTile(
      title: "Location",
      settingKey: AccountSettingScreen.KeyLocation,
      initialValue: 'YEMEN',
      onChange: (location) {},
    );
Widget buildPassword() => TextInputSettingsTile(
      title: "Password",
      settingKey: AccountSettingScreen.KeyPassword,
      initialValue: 'password',
      obscureText: true,
      onChange: (location) {},
      validator: (password) => password != null && password.length >= 6
          ? null
          : "Enter 6 Characters",
    );

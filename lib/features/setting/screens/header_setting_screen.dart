import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HeaderSettingScreen extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';
  const HeaderSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDarkMode(),
      ],
    );
  }
}

Widget buildDarkMode() => SwitchSettingsTile(
      settingKey: HeaderSettingScreen.keyDarkMode,
      title: "Dark Mode",
      leading: Icon(
        Icons.dark_mode,
        color: Colors.blueAccent,
      ),
      onChange: (darkMode) {
        // switchList = darkMode;
      },
    );

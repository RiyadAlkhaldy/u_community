import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:u_community/core/enums/user_enum.dart';
import 'package:u_community/core/utils/loader.dart';
import 'package:u_community/features/auth/repository/auth_repository.dart';

import '../../user/screen/user_profile_screen.dart';
import '../widgets/icon_widget.dart';

class UserAccount extends ConsumerStatefulWidget {
  const UserAccount({super.key});

  @override
  ConsumerState<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends ConsumerState<UserAccount> {
  bool initail = true;
  Map<String, dynamic>? user;

  @override
  Widget build(BuildContext context) {
    ref.watch(getUserProvider).then((value) async {
      user = value;
      initail = false;
      setState(() {});
      // print(value);
    });
    print(user);
    return initail == true
        ? const Loader()
        : SimpleSettingsTile(
            title: user![UserEnum.name.type],
            subtitle: 'Your Profile',
            leading: IconWidget(
              icon: Icons.person,
              color: Colors.green,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(UserProfileScreen.routeName);
            },
            child: UserProfileScreen(),
          );
    const Placeholder();
  }
}

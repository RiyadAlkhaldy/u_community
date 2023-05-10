import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:u_community/core/enums/user_enum.dart';
import 'package:u_community/core/utils/loader.dart';

import '../../../models/user_response_auth.dart';
import '../../user/repository/repository_user.dart';
import '../../user/screen/user_profile_screen.dart';
import '../widgets/icon_widget.dart';

class UserAccount extends ConsumerStatefulWidget {
  const UserAccount({super.key});

  @override
  ConsumerState<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends ConsumerState<UserAccount> {
  bool initail = true;

  @override
  Widget build(BuildContext context) {
    // ref.watch(getUserDetailes).when((value) {
    //   user = value;
    //   print('mmmmmmmmmmmmmmmmmmmmmm uuuuuuuuuuuser $user');

    //   initail = false;
    //   setState(() {});
    //   // print(value);
    // });

    return ref.watch(getUserProviderProfile).when(
        data: (data) {
          var name = data!.name;
          print(name);

          return SimpleSettingsTile(
            title: data.name,
            subtitle: 'Your Profile',
            leading: IconWidget(
              icon: Icons.person,
              color: Colors.green,
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(UserProfileScreen.routeName);
            },
            child: UserProfileScreen(
              id: data.id,
            ),
          );
        },
        error: (error, stackTrace) => Text('error $error'),
        loading: () => const Loader());

    const Placeholder();
  }
}

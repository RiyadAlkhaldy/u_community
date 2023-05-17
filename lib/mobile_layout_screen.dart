import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/core/enums/user_enum.dart';
import 'package:u_community/features/posts/screens/layout/post_layout%20_admin.dart';
import 'features/posts/screens/layout/post_layout.dart';
import 'features/setting/screens/setting_screen.dart';
import 'main.dart';
import 'res/widgets/bottom_navigation_barr.dart';

final currentIndexPage = StateProvider((ref) => 1);
final currentIndexTabBarPagePost = StateProvider<int>((ref) => 0);
final pProvider = StateProvider((ref) {
  final typeUser = int.parse(ref.watch(dataUserAuthentecationProvider)![UserEnum.typeUser.type]);
  return typeUser >=2? PostLayoutAdmin(): PostLayout();
});

class MobileLayoutScreen extends ConsumerStatefulWidget {
  static const String routeName = 'moile-layout-screen';

  const MobileLayoutScreen({super.key});

  @override
  _MobileLayoutScreenState createState() => _MobileLayoutScreenState();
}

// int currentIndex = 4;

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = ref.watch(currentIndexPage);
    return Scaffold(
      body: currentIndex == 0
          ? const SettingScreen()
          : currentIndex == 1
              ? ref.watch(pProvider)
              : ref.watch(pProvider),
      // : MyAppp(),
      bottomNavigationBar: BottomNavigationBarr(
        onTap: (value) {
          ref.read(currentIndexPage.notifier).state = value;
          // currentIndex = value;
        },
        currentIndex: ref.watch(currentIndexPage),
      ),
    );
  }
}

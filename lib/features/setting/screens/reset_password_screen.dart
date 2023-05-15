import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/screens/login.dart';
import '../repository/repository_reset_passwor.dart';

final showOldPasswordProvider = StateProvider<bool>((ref) => false);
final showNewPasswordProvider = StateProvider<bool>((ref) => false);

//---------------------
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static const String routeName = 'reset-password-screen';

  @override
  ConsumerState<ResetPasswordScreen> createState() => _LoginState();
}

GlobalKey<FormState> formState = GlobalKey();
TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordContoller = TextEditingController();

class _LoginState extends ConsumerState<ResetPasswordScreen> {
  bool isGoing = false;

  resetPassord() async {
    if (kDebugMode) {
      print('go to login');
    }
    Map map = {
      'context': context,
      'data': {
        'password': oldPasswordController.text.trim(),
        'new_password': newPasswordContoller.text.trim()
      }
    };
    final fmSt = formState.currentState;

    if (fmSt!.validate()) {
      ref.read(resetPasswordRepositoryProvider(map));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    oldPasswordController.clear();
    newPasswordContoller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(resetPasswordRepositoryProvider);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formState,
            child: content()),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // LogoSpace(context),
        const Text('تعيين كلمة سر جديدة',
            style: TextStyle(color: Colors.black)),
        const SizedBox(height: 20),
        const Text('Password Resest', style: TextStyle(color: Colors.black)),
        inputStyle(true, context),
        inputStyle(false, context),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: !isGoing
              ? registerOrLoginOrResetPasswordButton(
                  text: 'Password Reset',
                  context: context,
                  onTap: () async {
                    isGoing = true;
                    setState(() {});
                    await resetPassord();
                    isGoing = false;
                    setState(() {});
                  })
              : const CircularProgressIndicator(
                  strokeWidth: 20,
                  color: Colors.blue,
                ),
        ),
      ],
    );
  }

  //--------------LogoSpace--------------------

  // ignore: non_constant_identifier_names
  Widget LogoSpace(context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (!isKeyboardVisible) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.tealAccent,
                image: DecorationImage(
                    image: AssetImage('assets/images/pre.png'),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(80, 80),
                    bottomRight: Radius.elliptical(80, 80)),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 40.0),
              ),
            ),
          ],
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(top: 20),
          height: 150,
          width: 150,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0),
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        );
      }
    });
  }
}

//---------------InputStyle---------------------
Widget inputStyle(bool whatIs, context) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(right: 35, left: 35, top: 25, bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: (whatIs == true)
        ? inputUserOldPasswd(
            oldPasswordController,
            context,
          )
        : inputUserNewPasswd(newPasswordContoller, context),
  );
}

//---------------UserPassWordField--------------
Widget inputUserNewPasswd(
  TextEditingController controller,
  context,
) {
  return Consumer(
    builder: (_, WidgetRef ref, __) {
      return TextFormField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        obscureText: ref.watch(showNewPasswordProvider),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
          hintText: ' كلمة السر الجديدة',
          suffixIcon: Consumer(
            builder: (_, WidgetRef ref, __) {
              final showPass = ref.watch(showNewPasswordProvider);
              return IconButton(
                icon: showPass
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  ref
                      .read(showNewPasswordProvider.notifier)
                      .update((state) => !state);
                },
              );
            },
          ),
          hintTextDirection: TextDirection.rtl,
          hintMaxLines: 1,
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      );
    },
  );
}

//---------------UserPassWordField--------------
Widget inputUserOldPasswd(TextEditingController controller, context) {
  return Consumer(
    builder: (_, WidgetRef ref, __) {
      return TextFormField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        obscureText: ref.watch(showOldPasswordProvider),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
          hintText: 'كلمة السر القديمة',
          suffixIcon: Consumer(
            builder: (_, WidgetRef ref, __) {
              final showPass = ref.watch(showOldPasswordProvider);
              return IconButton(
                icon: showPass
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  ref
                      .read(showOldPasswordProvider.notifier)
                      .update((state) => !state);
                },
              );
            },
          ),
          hintTextDirection: TextDirection.rtl,
          hintMaxLines: 1,
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      );
    },
  );
}

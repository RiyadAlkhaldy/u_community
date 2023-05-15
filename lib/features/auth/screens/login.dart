import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import 'registration.dart';

final showPassProvider = StateProvider<bool>((ref) => false);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

//---------------------
class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String routeName = 'login';

  @override
  ConsumerState<Login> createState() => _LoginState();
}

GlobalKey<FormState> formState = GlobalKey();
TextEditingController emailContoller = TextEditingController();
TextEditingController passwordContoller = TextEditingController();

class _LoginState extends ConsumerState<Login> {
  bool isGoing = false;

  login() async {
    if (kDebugMode) {
      print('go to login');
    }

    final fmSt = formState.currentState;

    if (fmSt!.validate()) {
      // isGoing = true;
      // setState(() {});
      if (kDebugMode) {
        print('login');
      }
      await ref.read(authProvider).login(
          email: emailContoller.text.trim(),
          password: passwordContoller.text.trim(),
          context: context);
    }
    // isGoing == false;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formState,
          child: Content()),
      backgroundColor: Colors.white,
    );
  }

  Widget Content() {
    return Column(
      children: [
        LogoSpace(context),
        InputStyle(true, context),
        InputStyle(false, context),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: !isGoing
              ? registerOrLoginOrResetPasswordButton(
                  text: 'تسجيل الدخول',
                  context: context,
                  onTap: () async {
                    isGoing = true;
                    setState(() {});
                    await login();
                    isGoing = false;
                    setState(() {});
                  })
              : Container(
                  // decoration: BoxDecoration(color: Colors.black54),
                  // padding: EdgeInsets.symmetric(horizontal: 8),
                  child: CircularProgressIndicator(
                  strokeWidth: 20,
                  color: Colors.blue,
                )),
        ),
        // registerOrLoginButton(
        //   text: 'تسجيل الدخول',
        //   context: context,
        //   onTap: () async {
        //     login();
        //   },
        // ),
        // restPasswd(),
        customButton(
          text: 'إنشاء حساب',
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Registration.routeName,
              (route) => true,
            );
          },
        ),
      ],
    );
  }

  //--------------LogoSpace--------------------

  // ignore: non_constant_identifier_names
  Widget LogoSpace(context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (!isKeyboardVisible) {
        return Container(
          child: Stack(
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
          ),
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
Widget InputStyle(bool whatIs, context) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(right: 35, left: 35, top: 25, bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          // spreadRadius: 2,
          // blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: (whatIs == true)
        ? inputUserName(emailContoller, context)
        : inputUserPasswd(passwordContoller, context),
  );
}

//---------------UserNameField--------------
Widget inputUserName(TextEditingController controller, BuildContext context) {
  return TextFormField(
    validator: (input) =>
        input!.isValidEmail() ? null : "Check your syntax email ",
    // inputFormatters: [],
    style:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
    controller: controller,

    // textAlign: TextAlign.right,
    decoration: const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
      // suffixIcon:
      //     Icon(Icons.supervised_user_circle_rounded, color: Colors.black),
      hintText: 'Email',
      // labelText: 'Email',
      labelStyle: TextStyle(
        color: Colors.black45,
        fontSize: 14,
      ),
      // hintTextDirection: TextDirection.rtl,
      hintStyle: TextStyle(
        color: Colors.black45,
        fontSize: 14,
      ),
    ),
  );
}

//---------------UserPassWordField--------------
Widget inputUserPasswd(TextEditingController controller, context) {
  return Consumer(
    builder: (_, WidgetRef ref, __) {
      return TextFormField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        // textAlign: TextAlign.right,
        obscureText: ref.watch(showPassProvider),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
          hintText: 'Password',
          suffixIcon: Consumer(
            builder: (_, WidgetRef ref, __) {
              final showPass = ref.watch(showPassProvider);
              return IconButton(
                icon: showPass
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  ref.read(showPassProvider.notifier).update((state) => !state);
                },
              );
            },
          ),
          // suffixIcon: const Icon(
          //   Icons.lock,
          //   color: Colors.black,
          // ),
          // hintTextDirection: TextDirection.rtl,
          hintMaxLines: 1,
          // labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.black45,
            fontSize: 14,
          ),
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 14,
          ),
        ),
      );
    },
  );
}

//---------LoginButt--------

Widget registerOrLoginOrResetPasswordButton(
    {required String text,
    required BuildContext context,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
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

//---------SignupButton-------
Widget customButton(
    {required String text, required void Function()? onPressed}) {
  return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
    return Visibility(
      visible: !isKeyboardVisible,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 25, right: 20, left: 25),
            child: Divider(
              height: 30,
              color: Colors.blue,
            ),
          ),
          Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

//---------ResetPasswordButton
Widget restPasswd() {
  return RichText(
    text: TextSpan(children: [
      const TextSpan(
        text: "هل نسيت كلمة السر ؟",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      TextSpan(
          text: " اضغط هنا ",
          style: const TextStyle(
            color: Colors.blue,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {})
    ]),
  );
}

//---------end-------------

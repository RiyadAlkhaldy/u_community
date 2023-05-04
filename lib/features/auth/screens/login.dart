import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import 'registration.dart';

//---------------------
class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String routeName = 'login';

  @override
  ConsumerState<Login> createState() => _LoginState();
}

GlobalKey<FormState> formState = GlobalKey();
bool isDone = false;
TextEditingController emailContoller = TextEditingController();
TextEditingController passwordContoller = TextEditingController();
// login() async {}

class _LoginState extends ConsumerState<Login> {
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
        RegisterOrLoginButton(
          text: 'تسجيل الدخول',
          context: context,
          onTap: () async {
            print('go to login');

            final fmSt = formState.currentState;
            if (fmSt!.validate()) {
              print('auth');
              ref.read(authProvider).login(
                  email: emailContoller.text.trim(),
                  password: passwordContoller.text.trim(),
                  context: context);
            }
          },
        ),
        restPasswd(),
        CustomButton(
          text: 'إنشاء حساب',
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Registration.routeName);
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
                margin: EdgeInsets.only(bottom: 50),
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
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.only(top: 20),
          height: 150,
          width: 150,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0),
            child: Image(
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
    height: 40,
    margin: const EdgeInsets.only(right: 35, left: 35, top: 0, bottom: 20),
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
        ? inputUserName(emailContoller, context)
        : inputUserPasswd(passwordContoller, context),
  );
}

//---------------UserNameField--------------
Widget inputUserName(TextEditingController controller, BuildContext context) {
  return TextField(
    style:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
    controller: controller,
    textAlign: TextAlign.right,
    decoration: const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
      suffixIcon:
          Icon(Icons.supervised_user_circle_rounded, color: Colors.black),
      hintText: 'اسم المستخدم',
      hintTextDirection: TextDirection.rtl,
      hintStyle: TextStyle(
        fontSize: 14,
      ),
    ),
  );
}

//---------------UserPassWordField--------------
Widget inputUserPasswd(TextEditingController controller, context) {
  bool isObsecured = true;
  return TextFormField(
    controller: controller,
    style:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
    textAlign: TextAlign.right,
    obscureText: true,
    decoration: InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
      hintText: 'كلمة السر',
      prefixIcon: IconButton(
        icon: isObsecured ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        onPressed: () {
          //  setState((){
          //   _isObsecured =!_isObsecured;
          // });
        },
      ),
      suffixIcon: Icon(
        Icons.lock,
        color: Colors.black,
      ),
      hintTextDirection: TextDirection.rtl,
      hintMaxLines: 1,
      hintStyle: TextStyle(
        fontSize: 14,
      ),
    ),
  );
}

//---------LoginButt--------

Widget RegisterOrLoginButton(
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
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

//---------SignupButton-------
Widget CustomButton(
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
                style: TextStyle(
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



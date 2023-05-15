import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/screens/login.dart';
import '../repository/repository_reset_email.dart';

final showPasswordProvider = StateProvider<bool>((ref) => false);
// final showNewPasswordProvider = StateProvider<bool>((ref) => false);

//---------------------
class ResetEmailScreen extends ConsumerStatefulWidget {
  const ResetEmailScreen({Key? key}) : super(key: key);

  static const String routeName = 'reset-email-screen';

  @override
  ConsumerState<ResetEmailScreen> createState() => _LoginState();
}

GlobalKey<FormState> formState = GlobalKey();
TextEditingController oldEmailController = TextEditingController();
TextEditingController newEmailContoller = TextEditingController();
TextEditingController passwordContoller = TextEditingController();

class _LoginState extends ConsumerState<ResetEmailScreen> {
  bool isGoing = false;

  resetEmail() async {
    if (kDebugMode) {
      print('go to login');
    }
    Map map = {
      'context': context,
      'data': {
        'email': oldEmailController.text.trim(),
        'new_email': newEmailContoller.text.trim(),
        'password': passwordContoller.text.trim(),
      }
    };
    final fmSt = formState.currentState;

    if (fmSt!.validate()) {
      ref.read(resetEmailRepositoryProvider(map));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formState,
          child: content()),
      backgroundColor: Colors.white,
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('تعيين بريد إلكتروني جديد',
            style: TextStyle(color: Colors.black)),
        const SizedBox(height: 20),
        const Text('Email Resest', style: TextStyle(color: Colors.black)),
        // LogoSpace(context),
        inputStyle(true, context),
        inputStyle(false, context),
        inputUserPasswordContainer(passwordContoller, context),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: !isGoing
              ? registerOrLoginOrResetPasswordButton(
                  text: 'Email Reset',
                  context: context,
                  onTap: () async {
                    isGoing = true;
                    setState(() {});
                    await resetEmail();
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

  //--------------input password--------------------
  Widget inputUserPasswordContainer(
          TextEditingController textContoller, BuildContext context) =>
      Container(
          height: 50,
          margin:
              const EdgeInsets.only(right: 35, left: 35, top: 25, bottom: 20),
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
          child: inputUserPassword(passwordContoller, context));
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
          ? inputUserOldEmail(
              oldEmailController,
              context,
            )
          : inputUserNewEamil(newEmailContoller, context),
    );
  }

//---------------UserPassWordField--------------
  Widget inputUserNewEamil(
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
            hintText: ' new email',
            hintTextDirection: TextDirection.ltr,
            hintMaxLines: 1,
            hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        );
      },
    );
  }

//---------------UserPassWordField--------------
  Widget inputUserOldEmail(TextEditingController controller, context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return TextFormField(
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
            hintText: 'old Email',
            hintTextDirection: TextDirection.ltr,
            hintMaxLines: 1,
            hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        );
      },
    );
  }

  Widget inputUserPassword(TextEditingController controller, context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return TextFormField(
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),
          obscureText: ref.watch(showPasswordProvider),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
            hintText: 'Your Password',
            suffixIcon: Consumer(
              builder: (_, WidgetRef ref, __) {
                final showPass = ref.watch(showPasswordProvider);
                return IconButton(
                  icon: showPass
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    ref
                        .read(showPasswordProvider.notifier)
                        .update((state) => !state);
                  },
                );
              },
            ),
            hintTextDirection: TextDirection.ltr,
            hintMaxLines: 1,
            hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        );
      },
    );
  }
}

//---------------UserPassWordField--------------

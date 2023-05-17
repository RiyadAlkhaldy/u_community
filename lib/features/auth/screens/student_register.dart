// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/core/utils/utils.dart';
import '../../../core/utils/valiadate_inputs.dart';
import '../repository/auth_repository.dart';
import '../widgets/text_field_custom.dart';
import 'login.dart';

class StudentRegister extends ConsumerStatefulWidget {
  const StudentRegister({Key? key}) : super(key: key);
  static const String routeName = 'student-register';
  @override
  ConsumerState<StudentRegister> createState() => _StudentRegisterState();
}

class _StudentRegisterState extends ConsumerState<StudentRegister> {
  GlobalKey<FormState> formState = GlobalKey();
  bool isDone = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController univIdController = TextEditingController();
  TextEditingController IDNUmber = TextEditingController();
  bool isGoing = false;
  Future<void> register() async {
    final fmSt = formState.currentState;
    if (fmSt!.validate()) {
      print('auth');

      await ref.read(authProvider).registerStudent(
          email: emailController.text.trim(),
          uniId: univIdController.text.trim(),
          iDNumber: IDNUmber.text.trim(),
          type: 1,
          context: context);
    } else {
      if (kDebugMode) {
        print('no auth');
      }
      // showSnackBar(context: context, content: 'content');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formState,
      child: Column(
        children: [
          TextFieldCustom(
            validator: (input) =>
                input!.isValidEmail() ? null : "Check your syntax email ",
            hintText: 'Email',
            labelText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustom(
            hintText: 'University ID',
            labelText: 'University ID',
            controller: univIdController,
            validator: (val) => validInputAuth(val, 15, 5),
            keyboardType: TextInputType.number,
          ),
          TextFieldCustom(
            hintText: 'ID Number',
            labelText: 'ID number',
            controller: IDNUmber,
            validator: (val) => validInputAuth(val, 30, 6),
            keyboardType: TextInputType.number,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: !isGoing
                ? registerOrLoginOrResetPasswordButton(
                    text: 'تسجيل',
                    context: context,
                    onTap: () async {
                      isGoing = true;
                      setState(() {});
                      await register();
                      isGoing = false;
                      setState(() {});
                    })
                : const CircularProgressIndicator(
                    strokeWidth: 20,
                    color: Colors.blue,
                  ),
          ),
        ],
      ),
    );
  }
}

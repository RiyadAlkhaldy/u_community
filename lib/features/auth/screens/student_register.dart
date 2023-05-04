// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  register() async {
    setState(() {});

    final fmSt = formState.currentState;
    if (!fmSt!.validate()) {
      print('auth');
      isGoing = true;

      await AuthRepository().registerStudent(
          email: emailController.text.trim(),
          uniId: univIdController.text.trim(),
          IDNumber: IDNUmber.text.trim(),
          type: 1,
          context: context);
    }
    print('no auth');
    isGoing = false;

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: formState,
        child: Column(
          children: [
            TextFieldCustom(
              hintText: 'Email',
              labelText: 'Email',
              controller: emailController,
              validator: (val) => validInputAuth(val, 15, 7),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFieldCustom(
              hintText: 'University ID',
              labelText: 'University ID',
              controller: univIdController,
              validator: (val) => validInputAuth(val, 15, 3),
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
                  ? RegisterOrLoginButton(
                      text: 'تسجيل',
                      context: context,
                      onTap: () {
                        setState(() {
                          register();
                        });
                      })
                  : Container(
                      // decoration: BoxDecoration(color: Colors.black54),
                      // padding: EdgeInsets.symmetric(horizontal: 8),
                      child: CircularProgressIndicator(
                      strokeWidth: 20,
                      color: Colors.blue,
                    )),
            ),
          ],
        ),
      ),
    );
  }
}

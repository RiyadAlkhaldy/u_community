import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/valiadate_inputs.dart';
import '../../../mobile_layout_screen.dart';
import '../../../models/colloge_model.dart';
import '../repository/auth_repository.dart';
import '../widgets/text_field_custom.dart';
import 'login.dart';

class AdminRegister extends ConsumerStatefulWidget {
  const AdminRegister({super.key});

  @override
  ConsumerState<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends ConsumerState<AdminRegister> {
  GlobalKey<FormState> formState = GlobalKey();
  bool isDone = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController IDNUmber = TextEditingController();
  bool isGoing = false;
  register(context) async {
    setState(() {});

    final fmSt = formState.currentState;
    if (!fmSt!.validate()) {
      try {
        print('auth');
        isGoing = true;

        await ref.read(authProvider).registerAsAdmin(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: nameController.text.trim(),
            iDNumber: IDNUmber.text.trim(),
            collogeId: _selectedVal.toString(),
            type: 3,
            context: context);
      } catch (e) {
        print(e);
      }
    }

    print('no auth');
    isGoing = false;

    setState(() {});
  }

  List<Colloge> colloges = [];
  var _selectedVal;
  // String? _data;
  // bool? _isReady;

  // String? token = null;
  bool initial = true;
  @override
  Widget build(BuildContext context) {
    if (initial) {
      ref.read(authProvider).getAllColloges(context).then((value) async {
        setState(() {
          colloges = value!.toList();

          _selectedVal = colloges.first.id;
          initial = false;
        });
      });
    }
    return SafeArea(
      child: Container(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formState,
          child: Column(
            children: [
              TextFieldCustom(
                hintText: 'Your Name',
                labelText: 'the Name',
                controller: nameController,
                validator: (val) => validInputAuth(val, 15, 7),
                keyboardType: TextInputType.text,
              ),
              TextFieldCustom(
                hintText: 'Email',
                labelText: 'Email',
                controller: emailController,
                validator: (input) =>
                    input!.isValidEmail() ? null : "Check your syntax email ",
                keyboardType: TextInputType.emailAddress,
              ),
              TextFieldCustom(
                hintText: 'ID Number',
                labelText: 'ID number',
                controller: IDNUmber,
                validator: (val) => validInputAuth(val, 30, 6),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                hintText: 'Password',
                labelText: 'Password',
                controller: passwordController,
                validator: (val) => validInputAuth(val, 15, 3),
                keyboardType: TextInputType.number,
              ),
              if (!initial)
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton(
                      // isExpanded: true,

                      alignment: Alignment.center,
                      icon: Icon(Icons.person),
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Color.fromARGB(255, 175, 213, 240),
                      items: colloges.map((val) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: val.id,
                          child: Text(
                            val.name.toString(),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      value: _selectedVal,
                      onChanged: (value) {
                        setState(() {
                          _selectedVal = value;
                          print(value);
                        });
                      }),
                ),
              Container(
                padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: !isGoing
                    ? registerOrLoginButton(
                        text: 'تسجيل',
                        context: context,
                        onTap: () async {
                          await register(context);
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
      ),
    );
  }
}

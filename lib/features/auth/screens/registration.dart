import 'package:flutter/material.dart';

import 'admin_register.dart';
import 'login.dart';
import 'student_register.dart';
import 'teacher_register.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static const String routeName = 'registration';
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final List<String> _accountType = ['طالب', 'مدرس', 'عميد/رئيس قسم'];
  String? _hintTextInfo;
  String? _selectedValue;
  // String? _data;
  // bool? _isReady;
  @override
  void initState() {
    _selectedValue = _accountType[0];
    _hintTextInfo = 'ادخل رقم القيد الخاص بك';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    items: _accountType.map((val) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: val,
                        child: Text(
                          val,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                    value: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;

                        _hintTextInfo = _selectedValue == _accountType[0]
                            ? 'ادخل رقم القيد الخاص بك'
                            : _selectedValue == _accountType[1] ||
                                    _selectedValue == _accountType[2]
                                ? 'ادخل رقم الهويه الشخصيه '
                                : 'حدد نوع الحساب ';
                      });
                    }),
              ),
              _selectedValue == _accountType[0]
                  ? StudentRegister()
                  : _selectedValue == _accountType[1]
                      ? TeacherRegister()
                      : AdminRegister(),
              customButton(
                text: 'تسجيل الدخول',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Login.routeName, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

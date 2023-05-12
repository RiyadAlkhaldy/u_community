import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

class MessageAuthTeacher extends StatelessWidget {
  static const String routeName = 'message-auth-teacher';
  const MessageAuthTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.b,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'أنتظر حتى يبتم الموافقة على حسابك من قبل رئيس الكلية ثم يمكنك العودة لشاشة تسجيل الدخول',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, height: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(Login.routeName),
                  icon: const Icon(
                    FontAwesomeIcons.signIn,
                    color: Colors.blue,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

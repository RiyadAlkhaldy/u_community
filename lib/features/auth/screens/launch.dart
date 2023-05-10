import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'login.dart';
//------------------------------------------

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

//----------------------------------------------------------
class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // startTimer();
    super.initState();
  }

  //------- Method ------------
  startTimer() async {
    var duration = const Duration(seconds: 0);
    return Timer(duration, route);
  }

  //------- Method ------------
  void route() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Login.routeName,
      (route) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Container(
          // height: 30,
          // width: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.login, color: Colors.blue),
                    iconSize: 30.0,
                    onPressed: () {
                      route();
                    },
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

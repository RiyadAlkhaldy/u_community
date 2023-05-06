import 'package:flutter/material.dart';

class MessageToTeacherTempScreen extends StatefulWidget {
  static const String routeName = 'message-to-teacher-temp-scteen';
  const MessageToTeacherTempScreen({super.key});

  @override
  State<MessageToTeacherTempScreen> createState() =>
      _MessageToTeacherTempScreenState();
}

class _MessageToTeacherTempScreenState
    extends State<MessageToTeacherTempScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Wait For The Admin to agree ,Then You Can Login ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

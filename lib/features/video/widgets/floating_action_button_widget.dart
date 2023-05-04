import 'package:flutter/material.dart';

class FloatingActionButtonWidgett extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingActionButtonWidgett({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        child: Icon(Icons.add, size: 32),
        onPressed: onPressed,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
}

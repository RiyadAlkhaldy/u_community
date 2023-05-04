import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.validator,
      this.keyboardType})
      : super(key: key);
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        // obscureText: hintText == 'Password' ? true : false,
        keyboardType: keyboardType,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

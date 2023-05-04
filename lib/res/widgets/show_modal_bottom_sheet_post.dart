import 'package:flutter/material.dart';
// @immutable
class ButtonWidget extends StatelessWidget {
  final Color backgroundcolor;
  final String text;
  final Color textColor;
 final void Function()? onTap;
  ButtonWidget(
      {Key? key,
      required this.backgroundcolor,
      required this.text,
      required this.textColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 14,
      decoration: BoxDecoration(
          color: backgroundcolor, borderRadius: BorderRadius.circular(40)),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }
}

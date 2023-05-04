import 'package:flutter/material.dart';

import '../controller/text_post.dart'; 

class UploadTextScreen extends StatelessWidget {
  UploadTextScreen({super.key});
  static const String routeName = 'upload-text-screen';
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color(0xFF2e3253).withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: textEditingController,
                    maxLines: 10,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  UploadButtonWidget(
                    backgroundcolor: Colors.blue.withOpacity(0.5),
                    text: "Post",
                    textColor: Colors.white,
                    onTap: () async {
                      TextPost().textPost(
                          content: textEditingController.text.trim().toString(),
                          context: context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UploadButtonWidget extends StatelessWidget {
  final Color backgroundcolor;
  final String text;
  final Color textColor;
  void Function()? onTap;
  UploadButtonWidget(
      {Key? key,
      required this.backgroundcolor,
      required this.text,
      required this.textColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 150),
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
            color: backgroundcolor, borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }
}

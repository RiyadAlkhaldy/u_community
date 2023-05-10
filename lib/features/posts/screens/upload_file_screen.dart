import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/colloge_model.dart';
import '../../auth/repository/auth_repository.dart';
import '../../video/orientation/portrait_player_widget.dart';
import '../controller/upload_file.dart';
import 'upload_text_screen copy.dart';

class UploadFileScreen extends ConsumerStatefulWidget {
  // const UploadFileScreen({super.key});
  static const String routeName = 'upload-file-screen';
  final FileType type;
  UploadFileScreen({
    Key? key,
    required this.type,
  }) : super(key: key);
  PlatformFile? file;
  File? ifile;

  @override
  ConsumerState<UploadFileScreen> createState() => _UploadFileScreenState();
}

TextEditingController contentController = TextEditingController();

class _UploadFileScreenState extends ConsumerState<UploadFileScreen> {
  List<Colloge> colloges = [];

  var _selectedVal;

  // String? _data;
  bool initial = true;
  bool allows = false;
  @override
  Widget build(BuildContext context) {
    ref.read(authProvider).getAllColloges(context).then((value) async {
      await ref.watch(getUserProvider).then((map) async {
        if (int.parse(map['type']) == 3) {
          // allows = true;
          ref.read(allwoProvidr.notifier).state = true;
        }
      });

      // setState(() {
      colloges = value!.toList();

      // _selectedVal = colloges.first.id;
      ref.read(selectedVal.notifier).state = colloges.first.id!;
      initial = false;
      // });
    });

    // final upload = ref.watch(uploadFileProvider);
    @override
    void initState() {
      super.initState();
      ref.read(uploadFileProvider).path!.bytes!.clear();
      if (contentController.text.trim().isNotEmpty) {
        contentController.clear();
      }
    }

    if (contentController.text.trim().isNotEmpty) {
      contentController.clear();
    }

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.8),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          color: Color(0xFF2e3253).withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (ref.watch(uploadFileProvider).getFile() != null)
                    Container(
                      height: 300,
                      child: FileType.video == widget.type
                          ? PortraitPlayerWidget(
                              file: ref.watch(uploadFileProvider).getFile(),
                              type: widget.type,
                            )
                          : Image.file(ref.watch(uploadFileProvider).getFile(),
                              fit: BoxFit.contain),
                    ),
                  InputStyle(context: context, controller: contentController),
                  if (ref.watch(allwoProvidr))
                    Consumer(
                      builder: (_, WidgetRef rf, __) {
                        return dropDownListColloges(rf);
                      },
                    ),
                  const SizedBox(height: 20),
                  UploadButtonWidget(
                    backgroundcolor: Colors.blue.withOpacity(0.5),
                    text: "Select a file",
                    textColor: Colors.white,
                    onTap: () async {
                      await ref
                          .read(uploadFileProvider)
                          .pickFiles(type: widget.type);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  UploadButtonWidget(
                    backgroundcolor: Colors.blue.withOpacity(0.5),
                    text: "Upload",
                    textColor: Colors.white,
                    onTap: () async {
                      await ref.read(uploadFileProvider).upload(
                          type: widget.type == FileType.image ? 2 : 3,
                          context: context,
                          content: contentController.text.trim().isNotEmpty
                              ? contentController.text.trim()
                              : '',
                          colloge_id: ref.watch(selectedVal).toString());
                      // ref.read(uploadFileProvider).path!.bytes!.clear();
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

  Container dropDownListColloges(rf) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: DropdownButton(
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
          value: rf.watch(selectedVal),
          onChanged: (value) {
            // setState(() {
            // _selectedVal = value;
            rf.read(selectedVal.notifier).state = value!;
            // collogeIdcontroller.text. = value;
            print(value);
            // });
          }),
    );
  }
}

Widget InputStyle({BuildContext? context, TextEditingController? controller}) {
  return Container(
      height: 200,
      margin: EdgeInsets.only(top: 0, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InputUserName(
          hintText: '...', context: context!, controller: controller));
}

//---------------UserNameField--------------
Widget InputUserName(
    {String? hintText,
    required BuildContext context,
    TextEditingController? controller}) {
  return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      maxLines: 5,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        fillColor: Colors.blue,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(right: 0, left: 0, bottom: 6, top: 15),
        hintText: hintText,
        suffixText: 'الوصف أو العنوان',
        labelStyle:
            TextStyle(fontSize: 24, color: Colors.black.withOpacity(0.3)),
        hintTextDirection: TextDirection.rtl,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        suffixStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey),
      ));
}

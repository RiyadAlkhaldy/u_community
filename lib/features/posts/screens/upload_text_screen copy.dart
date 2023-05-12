import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/colloge_model.dart';
import '../../auth/repository/auth_repository.dart';
import '../controller/text_post.dart';

final allwoProvidr = StateProvider<bool>((ref) => false);
final selectedVal = StateProvider<int>((ref) => 1);

// _selectedVal
class UploadTextScreen extends ConsumerWidget {
  UploadTextScreen({super.key});
  static const String routeName = 'upload-text-screen';

  TextEditingController textEditingController = TextEditingController();
  // TextEditingController collogeIdcontroller = TextEditingController();

  List<Colloge> colloges = [];

  var _selectedVal;

  // String? _data;
  bool initial = true;
  bool allows = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authProvider).getAllColloges(context).then((value) async {
      await ref.watch(getUserProvider).then((map) async {
        if (int.parse(map['type']) >= 3) {
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
                  if (ref.watch(allwoProvidr))
                    Consumer(
                      builder: (_, WidgetRef rf, __) {
                        return dropDownListColloges(rf);
                      },
                    ),
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
                          context: context,
                          colloge_id: ref.watch(selectedVal).toString());
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

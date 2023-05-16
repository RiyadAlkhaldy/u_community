// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/colloge_model.dart';
import '../../auth/repository/auth_repository.dart';
import '../controller/text_post.dart';

final allwoProvidr = StateProvider<bool>((ref) => false);
final selectedVal = StateProvider<int>((ref) => 1);

// _selectedVal
class UploadTextScreen extends ConsumerStatefulWidget {
  const UploadTextScreen({super.key});
  static const String routeName = 'upload-text-screen';

  ConsumerState<UploadTextScreen> createState() => _UploadTextScreenState();
}

class _UploadTextScreenState extends ConsumerState<UploadTextScreen> {
  Future<void> textPostUpload() async {
    isGoing = true;
    setState(() {});
    await ref.read(uploadTextProvider).textPost(
        content: textEditingController.text.trim().toString(),
        context: context);
    isGoing = false;
    setState(() {});
  }

  TextEditingController textEditingController = TextEditingController();
  List<Colloge> colloges = [];
  bool initial = true;
  bool allows = false;
  bool isGoing = false;
  @override
  @override
  Widget build(BuildContext context) {
    if (initial) {
      // ref.read(allwoProvidr.notifier).state = false;
      ref.read(authProvider).getAllColloges(context).then((value) async {
        await ref.watch(getUserProviderfromSharedPrefernces).then((map) async {
          ref.read(allwoProvidr.notifier).state = false;

          if (int.parse(map['type']) >= 3) {
            allows = true;
            // ref.read(allwoProvidr.notifier).state = true;
            colloges = value!.toList();
            initial = false;

            ref.read(selectedVal.notifier).state = colloges.first.id!;
            setState(() {});
          }
        });
      });
    }

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
                  if (allows)
                    Consumer(
                      builder: (_, WidgetRef rf, __) {
                        return dropDownListColloges(rf);
                      },
                    ),
                  TextFormField(
                    controller: textEditingController,
                    maxLines: 10,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  UploadButtonWidget(
                    backgroundcolor: Colors.blue.withOpacity(0.5),
                    text: "Post",
                    textColor: Colors.white,
                    onTap: textPostUpload,
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
          icon: const Icon(Icons.person),
          borderRadius: BorderRadius.circular(10),
          dropdownColor: const Color.fromARGB(255, 175, 213, 240),
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
            rf.read(selectedVal.notifier).state = value!;
            if (kDebugMode) {
              print(value);
            }
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

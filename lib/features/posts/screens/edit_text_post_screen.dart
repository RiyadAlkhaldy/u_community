// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/features/posts/repository/repository_colloge_posts.dart';
import 'package:u_community/features/posts/repository/repository_section_posts.dart';
import '../../../mobile_layout_screen.dart';
import '../../../models/colloge_model.dart' as colloge;
import '../../../models/post_model.dart';
import '../../auth/repository/auth_repository.dart';
import '../repository/repository_posts.dart';

final allwoProvidr = StateProvider<bool>((ref) => false);
final selectedVal = StateProvider<int>((ref) => 1);

// _selectedVal
class EditTextPostScreen extends ConsumerStatefulWidget {
  const EditTextPostScreen({super.key});
  static const String routeName = 'edit-text-post-screen';

  ConsumerState<EditTextPostScreen> createState() => _UploadTextScreenState();
}

class _UploadTextScreenState extends ConsumerState<EditTextPostScreen> {
  Future<void> edittextPost(Posts post) async {
    isGoing = true;
    setState(() {});
    Posts? postEdited;
    if (ref.watch(currentIndexTabBarPagePost) == 0) {
      postEdited = await ref.read(postsProvider.notifier).editPost(
          post,
          textEditingController.text.trim(),
          ref.watch(selectedVal),
          context,
          ref);

      Navigator.maybePop(context);
    } else if (ref.watch(currentIndexTabBarPagePost) == 1) {
      postEdited = await ref.read(collogePostsProvider.notifier).editPost(
          post,
          textEditingController.text.trim(),
          ref.watch(selectedVal),
          context,
          ref);
    } else {
      postEdited = await ref.read(sectionPostsProvider.notifier).editPost(
          post,
          textEditingController.text.trim(),
          ref.watch(selectedVal),
          context,
          ref);
    }
    ref.read(postStateProvider.notifier).state = postEdited;
    // ignore: use_build_context_synchronously
    // ref.refresh(postStateProvider.notifier).state = postEdited;
    // await ref.read(uploadTextProvider).textPost(
    //     content: textEditingController.text.trim().toString(),

    //     context: context);
    isGoing = false;
    setState(() {});
  }

  TextEditingController textEditingController = TextEditingController();
  List<colloge.Colloge> colloges = [];
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
            initial = false;
            colloges = value!.toList();
            ref.read(selectedVal.notifier).state = colloges.first.id!;
            final postContent = ref.watch(postStateProvider)!.content;
            textEditingController.text.startsWith(postContent!);
            textEditingController.text = postContent;
            setState(() {});
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editting The post'),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color(0xFF2e3253).withOpacity(0.4),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SingleChildScrollView(
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
                    onTap: () {
                      final post = ref.watch(postStateProvider);

                      edittextPost(post!);
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

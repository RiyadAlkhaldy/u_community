import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/user_enum.dart';
import '../../../core/utils/loader.dart';
import '../../../main.dart';
import '../repository/repository_teachers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherRegisterations extends ConsumerStatefulWidget {
  static const String routeName = 'teacher-registerations';
  const TeacherRegisterations({super.key});

  @override
  ConsumerState<TeacherRegisterations> createState() =>
      _TeacherRegisterationsState();
}

class _TeacherRegisterationsState extends ConsumerState<TeacherRegisterations> {
  bool initail = true;
  bool dataLoaded = false;
  bool isGoing = false;

  addTeacher(int teacher_id) async {
    isGoing = true;
    setState(() {});
    await ref.read(teachersProvider.notifier).addTeacher(teacher_id, context);
    isGoing = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (initail == true) {
      ref.watch(teachersProvider.notifier).getAllTeachers.then((value) {
        setState(() {
          dataLoaded = true;
          initail = false;
        });
      });
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: dataLoaded == true
              ? Column(
                  children: ref.watch(teachersProvider).map((t) {
                  if (int.parse(ref.watch(dataUserAuthentecationProvider)![
                              UserEnum.typeUser.type]) ==
                          4 &&
                      int.parse(ref.watch(dataUserAuthentecationProvider)![
                              UserEnum.collogeId.type]) ==
                          t.collogeId) {
                    return Column(
                      children: [
                        // Table(children: [
                        //   Row(children: [],),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white70,
                          child: ListTile(
                              leading: IconButton(
                                  onPressed: () async {
                                    await addTeacher(t.id);
                                  },
                                  icon: Container(
                                    color: Colors.grey.shade100,
                                    child: isGoing
                                        ? const Loader()
                                        : const Icon(
                                            FontAwesomeIcons.add,
                                            size: 30,
                                            color: Colors.green,
                                          ),
                                  )),
                              subtitle: Container(
                                padding: const EdgeInsets.all(8.0),
                                // color: Colors.blue.shade100,
                                child: Text(
                                  t.email,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              title: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  t.name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        // Spacer()
                      ],
                    );
                  } else {
                    return const Text('');
                  }
                }).toList())
              : const Loader(),
        ),
      ),
    );
  }
}

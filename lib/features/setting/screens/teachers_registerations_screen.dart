import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/loader.dart';
import '../repository/repository_reachers.dart';

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
                return Column(
                  children: [
                    Container(
                      color: Colors.white24,
                      child: ListTile(
                          trailing: Text(
                            t.email,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 20, color: Colors.black),
                          ),
                          leading: Text(t.name,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.7),
                                  ))),
                    ),
                    // Spacer()
                  ],
                );
              }).toList())
            : Loader(),
      )),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_community/core/utils/utils.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import 'package:http/http.dart' as http;

import '../../../models/teacher_tamp_model.dart';

final teachersProvider =
    StateNotifierProvider<RepositoryTeachers, List<Teacher>>((ref) {
  return RepositoryTeachers();
});
final allTeachersProvider = FutureProvider<List<Teacher>>((ref) async {
  List<Teacher> teachers = [];
  await ref.watch(teachersProvider.notifier).getAllTeachers.then((value) {
    teachers = ref.watch(teachersProvider.notifier).state;
    return teachers;
  });
  return teachers;
});

final postStateProvider =
    StateNotifierProvider<RepositoryTeachers, List<Teacher>>(
        (ref) => RepositoryTeachers());

class RepositoryTeachers extends StateNotifier<List<Teacher>> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RepositoryTeachers() : super([]);
  final Dio dio = Dio();

  // RepositoryPosts();
  Future<List<Teacher>> get getAllTeachers async {
    SharedPreferences prefs = await _prefs;
    Map<String, dynamic?> data = {
      'colloge_id': prefs.getString(UserEnum.collogeId.type)
    };
    print(data);
    Response response;
    response = await dio.post(
      '${ApiUrl}auth-temp/get-all-users-tmep/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
      queryParameters: data,
    );
    print('ok');
    // print(response.statusCode == 200);
    if (response.statusCode == 200) {
      TeachersResponse res = TeachersResponse.fromMap(response.data);
      List<Teacher> teachers = res.teacher.map((e) => e).toList();
      state = [...teachers];
    }

    if (response.statusCode == 200) {
      print(state);
      // Navigator.pop(context);
    }
    return state;

    // ignore: use_build_context_synchronously
  }

  Future<void> addTeacher(int teacher_id, BuildContext context) async {
    SharedPreferences prefs = await _prefs;
    Map<String, dynamic?> data = {
      'id': teacher_id,
    };
    if (kDebugMode) {
      print(data);
    }
    Response response;
    response = await dio.post(
      '${ApiUrl}auth-temp/agree-for-teacher/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
      queryParameters: data,
    );
    print('ok');
    if (response.statusCode == 200 && response.data['status'] == 'success') {
      final teachers = [];
      for (var teacher in state) {
        if (teacher.id != teacher_id) teachers.add(teacher);
      }
      state = [...teachers];
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, content: response.data['message'].toString());
    }
  }

  void addLikeOrUndo(Teacher currentPost) {}

  // State =[...posts];
  void updatePost(Teacher currentPost) {}
}

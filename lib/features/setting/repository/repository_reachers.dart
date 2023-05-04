import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import 'package:http/http.dart' as http;

import '../model/teacher_tamp_model.dart';

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

final postStateProvider = StateProvider<Teacher?>((ref) => null);

class RepositoryTeachers extends StateNotifier<List<Teacher>> {
  RepositoryTeachers() : super([]);
  final Dio dio = Dio();

  // RepositoryPosts();
  Future<List<Teacher>> get getAllTeachers async {
    // SharedPreferences prefs = await _prefs;

    var response;
    // print(await prefs.getString(UserEnum.token.type));
    response = await dio.get(
      '${ApiUrl}auth-temp/get-all-users-tmep/',
      options: Options(headers: {
        // 'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
    );
    print('ok');
    print(response.data);
    TeachersResponse res = TeachersResponse.fromMap(response.data);
    List<Teacher> teachers = res.teacher.map((e) => e).toList();

    state = [...teachers];

    if (response.statusCode == 200) {
      print(state);
      // Navigator.pop(context);
    }
    return state;

    // ignore: use_build_context_synchronously
  }

  void deletePost(int post_id) {
    print('deleted number $post_id');
  }

  void addLikeOrUndo(Teacher currentPost) {}

  // State =[...posts];
  void updatePost(Teacher currentPost) {}
}

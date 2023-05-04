// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/post_model.dart';

// final postsResponseProvider =
//     StateNotifierProvider<PostRepository, dynamic>((ref) {
//   return PostRepository();
// });

// class PostRepository extends StateNotifier<ResponsePosts> {
//   PostRepository(super.state);
//   final Future<SharedPreferences> _prefs =
//       SharedPreferences.getInstance(); // final
//   late final ResponsePosts responsePosts;

//   final String url = 'http://10.0.2.2:8000/api/';
//   final dio = Dio();

//   Future<List<Posts>> get getAllPosts async {
//     final SharedPreferences prefs = await _prefs;

//     Response response;

//     response = await dio.post(
//       '${url}posts/get-all-posts/',
//       options: Options(headers: {
//         'authorization': 'Bearer ${prefs.getString('token')}',
//         "Accept": "application/json"
//       }),
//     );
//     print('ok');
//     print(response.data);
//     // responsePosts = ResponsePosts.fromJson(response.data);
//     state.responsePosts = ResponsePosts.fromJson(response.data);
//     if (response.statusCode == 200) {
//       print(responsePosts.posts);
//       // Navigator.pop(context);
//     }
//     return state.responsePosts.posts;

 
//   }
// }

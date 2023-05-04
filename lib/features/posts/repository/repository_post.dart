import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

mixin fetchData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String url = 'http://10.0.2.2:8000/api/';
  final dio = Dio();
  Stream<ResponsePosts> get getAllPosts async* {
    final SharedPreferences prefs = await _prefs;
    ResponsePosts? responsePosts;
    Response response;
    response = await dio.post(
      '${url}posts/get-all-posts/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString('token')}',
        "Accept": "application/json"
      }),
    );
    print('ok');
    print(response.data);
    ResponsePosts res = ResponsePosts.fromMap(response.data);
    responsePosts = responsePosts!
        .copyWith(posts: res.posts, message: res.message, status: res.status);

    if (response.statusCode == 200) {
      print(responsePosts.posts);
      // Navigator.pop(context);
    }
    // yield state;

    // ignore: use_build_context_synchronously
  }
}

// final myrequest = Provider<ResponsePosts>((ref) {
//   return MyRequest().getResponsePosts();

// });

final responseProvider =
    StateNotifierProvider<RepositoryPost, ResponsePosts>((ref) {
  // final myreq = ref.watch(myrequest);
  return RepositoryPost();
});
final AllPostsProvider = FutureProvider<ResponsePosts>((ref) async {
  await ref.read(responseProvider.notifier).getAllPosts;
  // ignore: invalid_use_of_protected_member
  final posts = ref.watch(responseProvider);
  return posts;
});

class RepositoryPost extends StateNotifier<ResponsePosts> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String url = 'http://10.0.2.2:8000/api/';
  final dio = Dio();

  RepositoryPost()
      : super(ResponsePosts(status: 'success', message: 'message', posts: []));

  // RepositoryPosts();
  Stream<ResponsePosts> get getAllPosts async* {
    final SharedPreferences prefs = await _prefs;
    final ResponsePosts responsePosts;

    Response response;

    response = await dio.post(
      '${url}posts/get-all-posts/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString('token')}',
        "Accept": "application/json"
      }),
    );
    print('ok');
    print(response.data);
    ResponsePosts res = ResponsePosts.fromMap(response.data);
    state = state.copyWith(
        posts: res.posts, message: res.message, status: res.status);

    if (response.statusCode == 200) {
      print(state.posts);
      // Navigator.pop(context);
    }
    // yield state;

    // ignore: use_build_context_synchronously
  }
}

// class MyRequest {
//   final Future<SharedPreferences> _prefs =
//       SharedPreferences.getInstance(); // final

//   final String url = 'http://10.0.2.2:8000/api/';
//   final dio = Dio();

//   Stream<ResponsePosts> get getAllPosts async* {
//     final SharedPreferences prefs = await _prefs;
//     final ResponsePosts responsePosts;

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
//     responsePosts = ResponsePosts.fromMap(response.data);

//     if (response.statusCode == 200) {
//       print(responsePosts.posts);
//       // Navigator.pop(context);
//     }
//     yield responsePosts;
//   }

//   getResponsePosts() {
//     late ResponsePosts rsponses;
//     getAllPosts.single.then((value) {
//       rsponses = value;
//       return rsponses as ResponsePosts;
//     });
//     // return rsponses;
//   }
// }

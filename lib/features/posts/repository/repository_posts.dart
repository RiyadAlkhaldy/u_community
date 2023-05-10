import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_community/core/utils/utils.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../models/post_model.dart';
// import 'package:http/http.dart' as http;

final postsProvider =
    StateNotifierProvider<RepositoryPosts, List<Posts>>((ref) {
  // final myreq = ref.watch(myrequest);
  return RepositoryPosts();
});
final allPostsProvider = FutureProvider<List<Posts>>((ref) async {
  List<Posts> posts = [];
  await ref.watch(postsProvider.notifier).getAllPosts.then((value) {
    posts = ref.watch(postsProvider.notifier).state;
    return posts;
  });
  return posts;
});

final postStateProvider = StateProvider<Posts?>((ref) => null);

class RepositoryPosts extends StateNotifier<List<Posts>> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  RepositoryPosts() : super([]);

  // RepositoryPosts();
  Future<List<Posts>> get getAllPosts async {
    SharedPreferences prefs = await _prefs;
    Response response;
    if (kDebugMode) {
      print(prefs.getString(UserEnum.token.type));
    }
    response = await dio.post(
      '${ApiUrl}posts/get-all-posts2/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
    );
    if (kDebugMode) {
      print('ok');
      print(response.data);
    }
    ResponsePosts res = ResponsePosts.fromMap(response.data);
    List<Posts> posts = res.posts.map((e) => e).toList();

    state = [...posts];

    if (response.statusCode == 200) {
      print(state);
      // Navigator.pop(context);
    }
    return state;

    // ignore: use_build_context_synchronously
  }

  void deletePost(int post_id) {
    print('deleted number $post_id');
    state = [
      for (var post in state)
        if (post.id != post_id) post,
    ];
  }

  void addLikeOrUndo(Posts currentPost, BuildContext context) async {
    List<Posts> posts = [];
    try {
      SharedPreferences prefs = await _prefs;
      Response response;
      if (kDebugMode) {
        print(prefs.getString(UserEnum.token.type));
      }

      if (currentPost.amILike == 0) {
        response = await dio.post('${ApiUrl}like/add-like/',
            options: Options(headers: {
              'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
              "Accept": "application/json"
            }),
            queryParameters: {'post_id': currentPost.id});
        state.forEach((post) {
          if (post.id == currentPost.id)
            post = post.copyWith(amILike: 1, likeCount: post.likeCount + 1);
          posts.add(post);
        });
      } else {
        response = await dio.post('${ApiUrl}like/un-like/',
            options: Options(headers: {
              'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
              "Accept": "application/json"
            }),
            queryParameters: {'post_id': currentPost.id});
        state.forEach((post) {
          if (post.id == currentPost.id)
            post = post.copyWith(amILike: 0, likeCount: post.likeCount - 1);
          posts.add(post);
        });
      }
      state = [...posts];
      // if(debug)
      print('liked post number ${currentPost}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showSnackBar(context: context, content: e.toString());
    }
  }

  void updateNumberTheComments(Posts currentPost, int value) {
    List<Posts> posts = [];

    state.forEach((post) {
      if (post.id == currentPost.id)
        post = currentPost.copyWith(
            commentCount: currentPost.commentCount + value);
      posts.add(post);
    });
    state = [...posts];

    print('update the post number ${currentPost}');
  }

  // State =[...posts];
  void updatePost(Posts currentPost) {
    List<Posts> posts = [];

    state.forEach((post) {
      if (post.id == currentPost.id) post = currentPost;
      posts.add(post);
    });
    state = [...posts];

    print('update the post number ${currentPost}');
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../models/post_model.dart';

final sectionPostsProvider =
    StateNotifierProvider<RepositorySectionPosts, List<Posts>>((ref) {
  // final myreq = ref.watch(myrequest);
  return RepositorySectionPosts();
});
final AllSectionPostsProvider = FutureProvider<List<Posts>>((ref) async {
  List<Posts> posts = [];
  await ref
      .read(sectionPostsProvider.notifier)
      .getAllSectionPosts
      .then((value) {
    posts = ref.watch(sectionPostsProvider.notifier).state;
    return posts;
  });
  return posts;
});

final sectionPostStateProvider = StateProvider<Posts?>((ref) => null);

class RepositorySectionPosts extends StateNotifier<List<Posts>> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  RepositorySectionPosts() : super([]);

  // RepositoryPosts();
  Future<List<Posts>> get getAllSectionPosts async {
    final SharedPreferences prefs = await _prefs;
    final ResponsePosts responsePosts;
    final Map<String, dynamic> data = {
      'section_id': prefs.getString('section_id'),
      'user_id': prefs.getString('id'),
    };
    Response response;

    response = await dio.post(
      '${ApiUrl}section/get-section-posts/',
      options: Options(
        headers: {
          'authorization': 'Bearer ${prefs.getString('token')}',
          "Accept": "application/json"
        },
      ),
      queryParameters: data,
    );
    print('ok');
    print(response.data);
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

  void addLikeOrUndo(Posts currentPost) {
    List<Posts> posts = [];
    if (currentPost.amILike == 0) {
      state.forEach((post) {
        if (post.id == currentPost.id)
          post = post.copyWith(amILike: 1, likeCount: post.likeCount + 1);
        posts.add(post);
      });
    } else {
      state.forEach((post) {
        if (post.id == currentPost.id) {
          post = post.copyWith(amILike: 0, likeCount: post.likeCount - 1);
        }
        posts.add(post);
      });
    }
    state = [...posts];
    // if(debug)
    if (kDebugMode) {
      print('liked post number $currentPost');
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

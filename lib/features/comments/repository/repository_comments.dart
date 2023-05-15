import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../models/comment_model.dart';

// final myrequest = Provider<ResponsePosts>((ref) {
//   return MyRequest().getResponsePosts();

// });

final commentsProvider =
    StateNotifierProvider<RepositoryComment, List<Comment>>((ref) {
  return RepositoryComment();
});
// final Provider = FutureProvider.family<, >((ref, ) async {
//   return ;
// });
final allcommentsProvider = FutureProvider.family((ref, int post_id) async {
  List<Comment> comments = [];
  return await ref
      .read(commentsProvider.notifier)
      .getAllComments(post_id)
      .then((value) {
    return value;
    // comments = ref.read(commentsProvider);
    // return comments;
  });
  // return comments;

  // ignore: invalid_use_of_protected_member
});

class RepositoryComment extends StateNotifier<List<Comment>> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  RepositoryComment() : super([]);

  // RepositoryPosts();
  Future<List<Comment>> getAllComments(int post_id) async {
    final SharedPreferences prefs = await _prefs;
    // final WidgetRef ref;

    Response? response;
    try {
      response = await dio.post(
        '${ApiUrl}comment/get-all-comments/',
        queryParameters: {'post_id': post_id},
        options: Options(headers: {
          'authorization': 'Bearer ${prefs.getString('token')}',
          "Accept": "application/json"
        }),
      );

      if (kDebugMode) {
        print('ok');
        print(response.data);
      }
      ResponseComment res =
          ResponseComment.fromMap(response.data as Map<String, dynamic>);
      List<Comment>? comments = res.comment;

      state = [...comments!];

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(state);
        }
      }
      return state;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return state;
  }

  Future<void> addComment(
      {required String comment, required int post_id}) async {
    final SharedPreferences prefs = await _prefs;
    final Comment _comment;

    Response? response;
    try {
      response = await dio.post(
        '${ApiUrl}comment/add-comment/',
        queryParameters: {
          'comment': comment,
          'user_id': prefs.getString('id'),
          'post_id': post_id,
        },
        options: Options(headers: {
          'authorization': 'Bearer ${prefs.getString('token')}',
          "Accept": "application/json"
        }),
      );
      if (kDebugMode) {
        print(response.data['comment']);
      }
      _comment =
          Comment.fromMap(response.data['comment'] as Map<String, dynamic>);
      // if (state.isEmpty) {
      //   // state = [_Comment];
      //   state.add(_comment);
      // } else {
      // }
      state = [_comment, ...state];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // print('add the Comment number ${currentComment}');
  }

  void updateComment(Comment currentComment) {
    List<Comment> comments = [];

    state.forEach((comment) {
      if (comment.id == currentComment.id) comment = currentComment;
      comments.add(comment);
    });
    state = [...comments];

    print('update the Comment number ${currentComment}');
  }

  Future<void> deleteComment(int comment_id) async {
    try {
      SharedPreferences prefs = await _prefs;

      var response;
      response = await dio.post('${ApiUrl}comment/delete-comment/',
          options: Options(headers: {
            'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
            "Accept": "application/json"
          }),
          queryParameters: {'id': comment_id});
    } catch (e) {
      print(e);
    }
    print('deleted number $comment_id');
    state = [
      for (var comment in state)
        if (comment.id != comment_id) comment,
    ];
  }
}

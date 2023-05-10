import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../models/comment_model.dart';

// final myrequest = Provider<ResponsePosts>((ref) {
//   return MyRequest().getResponsePosts();

// });

final commentsProvider =
    StateNotifierProvider<RepositoryComment, List<Comments>>((ref) {
  return RepositoryComment();
});
// final Provider = FutureProvider.family<, >((ref, ) async {
//   return ;
// });
final AllcommentsProvider = FutureProvider.family((ref, int post_id) async {
  List<Comments> comments = [];
  await ref
      .read(commentsProvider.notifier)
      .getAllComments(post_id)
      .then((value) {
    comments = ref.watch(commentsProvider.notifier).state;
    return comments;
  });
  return comments;

  // ignore: invalid_use_of_protected_member
});

class RepositoryComment extends StateNotifier<List<Comments>> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  RepositoryComment() : super([]);

  // RepositoryPosts();
  Future<List<Comments>> getAllComments(int post_id) async {
    final SharedPreferences prefs = await _prefs;
    final ResponseComment responseComment;
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
      print('ok');
      print(response.data);
    } catch (e) {
      print(e);
    }

    ResponseComment res = ResponseComment.fromMap(response!.data);
    List<Comments> comments = res.comments;

    state = [...comments];

    if (response.statusCode == 200) {
      print(state);
      // Navigator.pop(context);
    }
    // showSnackBar(context: context, content: state.toString());
    return state;

    // ignore: use_build_context_synchronously
  }

  void addComment({required String comment, required int post_id}) async {
    final SharedPreferences prefs = await _prefs;
    final Comments _Comment;

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
      print(response.data['comment']);
      _Comment = Comments.fromMap(response.data['comment']);
      if (state.isEmpty)
        state = [_Comment];
      else
        state = [_Comment, ...state];
    } catch (e) {
      print(e);
    }

    // print('add the Comment number ${currentComment}');
  }

  void updateComment(Comments currentComment) {
    List<Comments> comments = [];

    state.forEach((comment) {
      if (comment.id == currentComment.id) comment = currentComment;
      comments.add(comment);
    });
    state = [...comments];

    print('update the Comment number ${currentComment}');
  }

  void deleteComment(int comment_id) async {
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

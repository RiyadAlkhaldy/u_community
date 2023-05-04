// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../posts/models/post_model.dart';

class ResponseUserPosts {
  final String status;
  final String message;
  final List<Posts> posts;
  ResponseUserPosts({
    required this.status,
    required this.message,
    required this.posts,
  });

  ResponseUserPosts copyWith({
    String? status,
    String? message,
    List<Posts>? posts,
  }) {
    return ResponseUserPosts(
      status: status ?? this.status,
      message: message ?? this.message,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'posts': posts.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseUserPosts.fromMap(Map<String, dynamic> map) {
    return ResponseUserPosts(
      status: map['status'] as String,
      message: map['message'] as String,
      posts: List<Posts>.from(
        (map['posts']).map<Posts>(
          (x) => Posts.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseUserPosts.fromJson(String source) =>
      ResponseUserPosts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResponseUserPosts(status: $status, message: $message, posts: $posts)';

  @override
  bool operator ==(covariant ResponseUserPosts other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        listEquals(other.posts, posts);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ posts.hashCode;
}

// class Posts {
//   Posts(
//       {required this.id,
//       required this.content,
//       required this.type,
//       this.url,
//       required this.userId,
//       this.sectionId,
//       required this.collogeId,
//       required this.createdAt,
//       required this.updatedAt,
//       required this.commentCount,
//       required this.likeCount,
//       required this.amILike});
//   late final int id;
//   late final String content;
//   late final int type;
//   late final Null url;
//   late final int userId;
//   late final int? sectionId;
//   late final int collogeId;
//   late final String createdAt;
//   late final String updatedAt;
//   late final int commentCount;
//   late final int likeCount;
//   late final int amILike;

//   Posts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     content = json['content'];
//     type = json['type'];
//     url = null;
//     userId = json['user_id'];
//     sectionId = null;
//     collogeId = json['colloge_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     commentCount = json['comment_count'];
//     likeCount = json['like_count'];
//     amILike = json['amILike'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['content'] = content;
//     _data['type'] = type;
//     _data['url'] = url;
//     _data['user_id'] = userId;
//     _data['section_id'] = sectionId;
//     _data['colloge_id'] = collogeId;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['comment_count'] = commentCount;
//     _data['like_count'] = likeCount;
//     _data['amILike'] = amILike;
//     return _data;
//   }

//   Posts copyWith({
//     int? id,
//     String? content,
//     int? type,
//     Null? url,
//     int? userId,
//     int? sectionId,
//     int? collogeId,
//     String? createdAt,
//     String? updatedAt,
//     int? commentCount,
//     int? likeCount,
//     int? amILike,
//   }) {
//     return Posts(
//       id: id ?? this.id,
//       content: content ?? this.content,
//       type: type ?? this.type,
//       url: url ?? this.url,
//       userId: userId ?? this.userId,
//       sectionId: sectionId ?? this.sectionId,
//       collogeId: collogeId ?? this.collogeId,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       commentCount: commentCount ?? this.commentCount,
//       likeCount: likeCount ?? this.likeCount,
//       amILike: amILike ?? this.amILike,
//     );
//   }
// }

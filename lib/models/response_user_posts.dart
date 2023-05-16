// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'post_model.dart';

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

import 'dart:convert';

import 'package:flutter/foundation.dart';

class ResponseComment {
  ResponseComment({
    required this.status,
    required this.comments,
  });
  final String status;
  final List<Comments> comments;

  ResponseComment copyWith({
    String? status,
    List<Comments>? comment,
  }) {
    return ResponseComment(
      status: status ?? this.status,
      comments: comment ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'comment': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseComment.fromMap(Map<String, dynamic> map) {
    return ResponseComment(
      status: map['status'] as String,
      comments:
          List.from(map['comment']).map((e) => Comments.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseComment.fromJson(String source) =>
      ResponseComment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseComment(status: $status, comment: $comments)';

  @override
  bool operator ==(covariant ResponseComment other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.comments, comments);
  }

  @override
  int get hashCode => status.hashCode ^ comments.hashCode;
}

class Comments {
  Comments({
    required this.id,
    required this.comment,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.img,
  });
  final int id;
  final String comment;
  final int userId;
  final int postId;
  final String createdAt;
  final String updatedAt;
  final String? name;
  final String? img;

  Comments copyWith({
    int? id,
    String? comment,
    int? userId,
    int? postId,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? img,
  }) {
    return Comments(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'user_id': userId,
      'post_id': postId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'img': img,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      id: map['id'],
      comment: map['comment'],
      userId: int.parse(map['user_id'].toString()),
      postId: int.parse(map['post_id'].toString()),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      name: map['name'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(String source) =>
      Comments.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, comment: $comment, userId: $userId, postId: $postId, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, img: $img)';
  }

  @override
  bool operator ==(covariant Comments other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.comment == comment &&
        other.userId == userId &&
        other.postId == postId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.name == name &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        comment.hashCode ^
        userId.hashCode ^
        postId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        name.hashCode ^
        img.hashCode;
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first

class CommentLikeNumber {
  CommentLikeNumber({
    required this.status,
    required this.numberComments,
    required this.numberLikes,
  });
  late final String status;
  late final int numberComments;
  late final int numberLikes;

  CommentLikeNumber copyWith({
    String? status,
    int? numberComments,
    int? numberLikes,
  }) {
    return CommentLikeNumber(
      status: status ?? this.status,
      numberComments: numberComments ?? this.numberComments,
      numberLikes: numberLikes ?? this.numberLikes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'numberComments': numberComments,
      'numberLikes': numberLikes,
    };
  }

  factory CommentLikeNumber.fromMap(Map<String, dynamic> map) {
    return CommentLikeNumber(
      status: map['status'],
      numberComments: map['numberComments'],
      numberLikes: map['numberLikes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentLikeNumber.fromJson(String source) =>
      CommentLikeNumber.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CommentLikeNumber(status: $status, numberComments: $numberComments, numberLikes: $numberLikes)';

  @override
  bool operator ==(covariant CommentLikeNumber other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.numberComments == numberComments &&
        other.numberLikes == numberLikes;
  }

  @override
  int get hashCode =>
      status.hashCode ^ numberComments.hashCode ^ numberLikes.hashCode;
}

///
class Commmment {
  String authorName;
  String authorImageUrl;
  String text;

  Commmment({
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
  });
}

final List<Commmment> comments = [
  Commmment(
    authorName: 'Angel',
    authorImageUrl: 'assets/images/user2.png',
    text: 'Loving this photo!!',
  ),
  Commmment(
    authorName: 'Charlie',
    authorImageUrl: 'assets/images/user3.png',
    text: 'One of the best photos of you...',
  ),
  Commmment(
    authorName: 'Angelina Martin',
    authorImageUrl: 'assets/images/user4.png',
    text: 'Can\'t wait for you to post more!',
  ),
  Commmment(
    authorName: 'Jax',
    authorImageUrl: 'assets/images/user1.png',
    text: 'Nice job',
  ),
  Commmment(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/images/user0.png',
    text: 'Thanks everyone :)',
  ),
];

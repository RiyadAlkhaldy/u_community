// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPostModel {
  final int id;
  final String title;
  final String body;
  final DateTime date;
  final int likes;
  final int unLikes;
  final int commentsNumber;
  UserPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.likes,
    required this.unLikes,
    required this.commentsNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'date': date.millisecondsSinceEpoch,
      'likes': likes,
      'unLikes': unLikes,
      'commentsNumber': commentsNumber,
    };
  }

  factory UserPostModel.fromMap(Map<String, dynamic> map) {
    return UserPostModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      likes: map['likes'] as int,
      unLikes: map['unLikes'] as int,
      commentsNumber: map['commentsNumber'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);
}

//

final listUserPostsModelFututre =
    FutureProvider<List<UserPostModel>>((ref) async {
  await Future.delayed(Duration(seconds: 5));
  return await listUserPosstModel;
  //  listUserPosstModel.map((userpost) {
  //   return UserPostModel.fromMap(userpost.toMap());
  // }).toList();
});

//
List<UserPostModel> listUserPosstModel = [
  UserPostModel(
      id: 1,
      title: "Post1",
      body: "content post1",
      date: DateTime.now(),
      likes: 55,
      unLikes: 5,
      commentsNumber: 20),
  UserPostModel(
      id: 2,
      title: "Post2",
      body: "content post2",
      date: DateTime.now(),
      likes: 55,
      unLikes: 5,
      commentsNumber: 20),
  UserPostModel(
      id: 3,
      title: "Post3",
      body: "content post3",
      date: DateTime.now(),
      likes: 55,
      unLikes: 5,
      commentsNumber: 20),
  UserPostModel(
      id: 4,
      title: "Post4",
      body: "content post4",
      date: DateTime.now(),
      likes: 55,
      unLikes: 5,
      commentsNumber: 20),
  UserPostModel(
      id: 5,
      title: "Post5",
      body: "content post5",
      date: DateTime.now(),
      likes: 55,
      unLikes: 5,
      commentsNumber: 20)
];

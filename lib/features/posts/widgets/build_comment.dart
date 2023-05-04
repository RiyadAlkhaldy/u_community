import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/comment_model.dart';
import '../repository/repository_comments.dart';

Widget buildComment(int index, BuildContext context, Comments comment) {
  return Consumer(
    builder: (_, WidgetRef ref, __) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: CircleAvatar(
              child: ClipOval(
                child: Image(
                  height: 50.0,
                  width: 50.0,
                  image: AssetImage(comments[index].authorImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: comment.name!.isEmpty
              ? Text('the name prop is null',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
              : Text(comment.name!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
          subtitle: Text(
            comment.comment,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontSize: 16),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.grey,
              onPressed: () {
                print('delete////');
                ref.read(commentsProvider.notifier).deleteComment(comment.id);
              }),
        ),
      );
    },
  );
}

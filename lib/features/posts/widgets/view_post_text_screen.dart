// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../models/post_model.dart';

class ViewPostText extends StatelessWidget {
  final Posts post;

  ViewPostText({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () => print('Like post'),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Container(
            child: Text(
          post.content!,
          // overflow: TextOverflow.ellipsis,
          maxLines: 4,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              height: 1.5,
              overflow: TextOverflow.ellipsis,
              color: Colors.black),
        )),
      ),
    );
  }
}

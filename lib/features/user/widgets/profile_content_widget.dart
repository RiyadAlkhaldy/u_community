import 'package:flutter/material.dart';

class ProfilePostContent extends StatelessWidget {
  const ProfilePostContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 400,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}

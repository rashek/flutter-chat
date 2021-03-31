import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import './animation_widget/small_post.dart';
import './animation_widget/large_post.dart';

class PostAnimation extends StatelessWidget {
  final String postCreator;
  final String postDescription;
  final String postImage;

  const PostAnimation(this.postCreator, this.postDescription, this.postImage);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        // transitionDuration: Duration(milliseconds: 500),
        closedBuilder: (context, action) {
      return SmallPost(postCreator, postDescription, postImage);
    }, openBuilder: (context, action) {
      return LargePost(postCreator, postDescription, postImage);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TaskSlideFadeAnimation extends StatelessWidget {
  final int index;
  final Widget child;
  final double horizontalOffset;
  final int animationDuration;
  const TaskSlideFadeAnimation({
    Key? key,
    required this.index,
    required this.child,
    this.horizontalOffset = 0,
    this.animationDuration = 225,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: animationDuration),
      child: SlideAnimation(
        horizontalOffset: horizontalOffset,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}

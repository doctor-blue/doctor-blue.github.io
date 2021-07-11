import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;

  Animator(this.child, this.time);

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    timer = Timer(widget.time, animationController.forward);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Container();
      },
      child: widget.child,
      // builder: (BuildContext context, Widget child) {
      //   return Conta(
      //     opacity: animation.value,
      //     child: Transform.translate(
      //       offset: Offset(0.0, (-50)+ animation.value * 50),
      //       child: child,
      //     ),
      //   );
      // },
    );
  }
}

late Timer timer;
Duration duration = Duration();

wait() {
  if (!timer.isActive) {
    timer = Timer(Duration(microseconds: 120), () {
      duration = Duration();
    });
  }
  duration += Duration(milliseconds: 300);
  return duration;
}

class WidgetAnimator extends StatelessWidget {
  final Widget child;

  WidgetAnimator({required this.child});

  @override
  Widget build(BuildContext context) {
    return Animator(child, wait());
  }
}
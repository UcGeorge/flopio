import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app/constants.dart';

class SmoothScrollView extends StatefulWidget {
  final ListView child;
  final ScrollController controller;
  const SmoothScrollView({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  _SmoothScrollViewState createState() => _SmoothScrollViewState();
}

class _SmoothScrollViewState extends State<SmoothScrollView> {
  var scroll = 0.0;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        int millis = NORMAL_SCROLL_ANIMATION_LENGTH_MS;
        if (pointerSignal is PointerScrollEvent) {
          if (pointerSignal.scrollDelta.dy > 0) {
            scroll += SCROLL_SPEED;
          } else {
            scroll -= SCROLL_SPEED;
          }
          if (scroll > widget.controller.position.maxScrollExtent) {
            scroll = widget.controller.position.maxScrollExtent;
            millis = NORMAL_SCROLL_ANIMATION_LENGTH_MS ~/ 2;
          } else if (scroll < 0) {
            scroll = 0;
            millis = NORMAL_SCROLL_ANIMATION_LENGTH_MS ~/ 2;
          }

          widget.controller.animateTo(
            scroll,
            duration: Duration(milliseconds: millis),
            curve: Curves.linear,
          );
        }
      },
      child: widget.child,
    );
  }
}

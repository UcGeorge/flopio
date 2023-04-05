import 'package:flutter/material.dart';

import '../../../app/colors.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle(
      {Key? key,
      required this.maxRadius,
      required this.minRadius,
      required this.duration})
      : super(key: key);

  final double maxRadius;
  final double minRadius;
  final Duration duration;
  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CircleAvatar(
        radius: widget.minRadius +
            (_controller.value * (widget.maxRadius - widget.minRadius)),
        backgroundColor: AppColors.thisWhite.withOpacity(.3),
      ),
    );
  }
}

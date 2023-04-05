import 'package:flutter/material.dart';

import '../../../../app/colors.dart';

class FileImageLoadingBuilder extends StatelessWidget {
  const FileImageLoadingBuilder({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.loadingIndicator,
    required this.radius,
    required this.widget,
    this.progress,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? loadingIndicator;
  final int? progress;
  final double radius;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    if (progress != null) {
      return widget;
    }
    return loadingIndicator ??
        Center(
          child: CircleAvatar(
            backgroundColor:
                backgroundColor ?? AppColors.blueGrey.withOpacity(.3),
            radius: radius,
            child: CircularProgressIndicator(
              color: accent ?? AppColors.violet,
              value: (progress == null || progress == 100)
                  ? null
                  : (progress! / 100),
            ),
          ),
        );
  }
}

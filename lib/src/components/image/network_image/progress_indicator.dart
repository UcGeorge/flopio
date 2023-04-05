import 'package:flutter/material.dart';

import '../../../../app/colors.dart';

class NetworkImageProgressIndicator extends StatelessWidget {
  const NetworkImageProgressIndicator({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.loadingIndicator,
    required this.radius,
    this.downloadProgress,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final downloadProgress;
  final Widget? loadingIndicator;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: loadingIndicator ??
          Center(
            child: CircleAvatar(
              backgroundColor:
                  backgroundColor ?? AppColors.blueGrey.withOpacity(.3),
              radius: radius,
              child: CircularProgressIndicator(
                color: accent ?? AppColors.violet,
                value: downloadProgress.progress,
              ),
            ),
          ),
    );
  }
}

/*
const SizedBox(width: 8),
ElevatedButton(
  onPressed: () => !mounted ? doNothing() : setState(() {}),
  style: ElevatedButton.styleFrom(
    primary: violet,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  child: Text(
    'Reload',
    overflow: TextOverflow.ellipsis,
    style: nunito.copyWith(
      fontSize: 14,
      color: Colors.white,
    ),
  ),
),
*/
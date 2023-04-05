import 'package:flutter/material.dart';

import '../../../app/colors.dart';

class ShenChapterNavButton extends StatelessWidget {
  const ShenChapterNavButton({
    Key? key,
    required this.forward,
    required this.enabled,
    required this.onTap,
  }) : super(key: key);

  final bool enabled;
  final bool forward;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTap: () => enabled ? onTap() : () {},
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.blueGrey.withOpacity(enabled ? 1 : .3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: RotatedBox(
              quarterTurns: forward ? 0 : 2,
              child: Icon(
                Icons.fast_forward_rounded,
                color: AppColors.white.withOpacity(enabled ? 1 : .3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

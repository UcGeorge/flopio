import 'package:flutter/material.dart';

import '../../../../app/colors.dart';
import '../../../../app/fonts.dart';
import '../../../../data/models/shen_image.dart';
import '../../../../util/log.util.dart';

class FileImageErrorBuilder extends StatelessWidget {
  const FileImageErrorBuilder({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    required this.radius,
    required this.shouldRetry,
    required this.source,
    required this.errorObj,
    this.stackTrace,
    this.onRetry,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Object errorObj;
  final Widget? errorPlaceholder;
  final VoidCallback? onRetry;
  final double radius;
  final bool shouldRetry;
  final ImageSource source;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    LogUtil.devLog("FileImageErrorBuilder", message: '$errorObj');
    // LogUtil.devLog("FileImageErrorBuilder", message: '$obj);
    return shouldRetry
        ? SizedBox(
            height: 200,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: backgroundColor ??
                      (AppColors.blueGrey)
                          .withOpacity(errorPlaceholder == null ? .67 : .3),
                  radius: radius,
                  child: errorPlaceholder ??
                      Icon(
                        Icons.error_outline_rounded,
                        color: accent ?? AppColors.violet,
                        size: radius,
                      ),
                ),
                Text(
                  'The image could not be loaded',
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.nunito.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.violet,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.nunito.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
          )
        : Center(
            child: CircleAvatar(
              backgroundColor: backgroundColor ??
                  (AppColors.blueGrey)
                      .withOpacity(errorPlaceholder == null ? .67 : .3),
              radius: radius,
              child: errorPlaceholder ??
                  Icon(
                    Icons.error_outline_rounded,
                    color: accent ?? AppColors.violet,
                    size: radius,
                  ),
            ),
          );
  }
}

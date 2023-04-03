import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../models/inapp_alert.dart';

class InAppAlertWidget extends StatelessWidget {
  const InAppAlertWidget({
    Key? key,
    required this.alertType,
    required this.text,
  }) : super(key: key);

  final AlertType alertType;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: InAppAlert.kBarHeight,
        child: Container(
          height: InAppAlert.kBarHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xffEAF2F6).withOpacity(.6),
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xff083652).withOpacity(.1),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.only(left: 18, right: 22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset(InAppAlert.iconUrl(alertType)),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: (alertType == AlertType.error
                          ? AppColors.red
                          : alertType == AlertType.warning
                              ? AppColors.orange
                              : AppColors.accentGreen)
                      .withOpacity(.15),
                  child: Icon(
                    (alertType == AlertType.error
                        ? Icons.error_outline_rounded
                        : alertType == AlertType.warning
                            ? Icons.warning_amber_rounded
                            : Icons.notifications_rounded),
                    size: 16,
                    color: alertType == AlertType.error
                        ? AppColors.red
                        : alertType == AlertType.warning
                            ? AppColors.orange
                            : AppColors.accentGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: InAppAlert.kTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

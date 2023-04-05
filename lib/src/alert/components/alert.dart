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
      child: Container(
        // height: InAppAlert.kBarHeight,
        // clipBehavior: Clip.antiAlias,
        constraints: const BoxConstraints(minHeight: 48),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: AppColors.white.withOpacity(.15),
            width: 1,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          color: AppColors.blueGrey.withOpacity(.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: AppColors.white.withOpacity(.15),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // SvgPicture.asset(InAppAlert.iconUrl(alertType)),
            Icon(
              (alertType == AlertType.error
                  ? Icons.error_outline_rounded
                  : alertType == AlertType.warning
                      ? Icons.warning_amber_rounded
                      : Icons.info_outline_rounded),
              size: 16,
              color: (alertType == AlertType.error
                  ? AppColors.red
                  : alertType == AlertType.warning
                      ? AppColors.orange
                      : Colors.blue),
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
    );
  }
}

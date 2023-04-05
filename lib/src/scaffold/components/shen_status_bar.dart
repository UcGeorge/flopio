import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../state/status_bar.state.dart';
import '../../../util/screen.util.dart';

class ShenStatusBar extends StatelessWidget {
  const ShenStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, Widget>>(
      stream: StatusBarState.lItems.stream,
      initialData: StatusBarState.lItems.value,
      builder: (context, lItemsSnapshot) {
        return StreamBuilder<Map<String, Widget>>(
          stream: StatusBarState.rItems.stream,
          initialData: StatusBarState.rItems.value,
          builder: (context, rItemsSnapshot) {
            return Container(
              height: 20,
              width: ScreenUtil.screenSize(context).width,
              color: AppColors.purple,
              child: Row(
                children: [
                  ...lItemsSnapshot.data!.values,
                  const Spacer(),
                  ...rItemsSnapshot.data!.values,
                ],
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'window_buttons.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          SizedBox(width: 90, child: MoveWindow()),
          Expanded(child: MoveWindow()),
          const ShenAppBar(),
          Expanded(child: MoveWindow()),
          const WindowButtons()
        ],
      ),
    );
  }
}

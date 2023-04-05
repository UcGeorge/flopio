import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../scaffold/components/window_buttons.dart';
import '../chapter.flow.dart';
import 'header.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
    required this.flow,
  });
  final ChapterFlow flow;

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(
              child: ChapterHeader(flow: flow),
            ),
          ),
          const WindowButtons()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../chapter.flow.dart';

class ChapterCloseButton extends StatefulWidget {
  const ChapterCloseButton({
    Key? key,
    this.quarterTurns,
    required this.enabled,
    required this.flow,
  }) : super(key: key);

  final bool enabled;
  final ChapterFlow flow;
  final int? quarterTurns;

  @override
  State<ChapterCloseButton> createState() => _ChapterCloseButtonState();
}

class _ChapterCloseButtonState extends State<ChapterCloseButton> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: RotatedBox(
        quarterTurns: widget.quarterTurns ?? 0,
        child: GestureDetector(
          onTap: () => widget.flow.closeChapter(context),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isHovering && widget.enabled
                  ? AppColors.white.withOpacity(.15)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              size: 16,
              color: !widget.enabled
                  ? Theme.of(context).iconTheme.color!.withOpacity(0.3)
                  : Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}

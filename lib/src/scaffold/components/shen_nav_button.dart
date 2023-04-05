import 'package:flutter/material.dart';

import '../../../app/colors.dart';

class ShenNavButton extends StatefulWidget {
  const ShenNavButton({
    Key? key,
    this.quarterTurns,
    required this.onTap,
    required this.enabled,
  }) : super(key: key);

  final bool enabled;
  final VoidCallback onTap;
  final int? quarterTurns;

  @override
  State<ShenNavButton> createState() => _ShenNavButtonState();
}

class _ShenNavButtonState extends State<ShenNavButton> {
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
          onTap: widget.enabled ? widget.onTap : () {},
          child: Container(
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.symmetric(vertical: .5),
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

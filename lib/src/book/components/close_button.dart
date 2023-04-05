import 'package:flutter/material.dart';

import '../../../state/book.state.dart';

class DVCloseButton extends StatefulWidget {
  const DVCloseButton({Key? key}) : super(key: key);

  @override
  DVCloseButtonState createState() => DVCloseButtonState();
}

class DVCloseButtonState extends State<DVCloseButton> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => BookState.state.update(null),
        child: Text(
          'CLOSE',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 11,
              color: isHovering
                  ? Colors.white.withOpacity(0.8)
                  : Colors.white.withOpacity(0.5),
              letterSpacing: 1.5),
        ),
      ),
    );
  }
}

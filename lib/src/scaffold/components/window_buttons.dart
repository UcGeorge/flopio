import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../../app/colors.dart';

final buttonColors = WindowButtonColors(
    iconNormal: AppColors.white.withOpacity(.5),
    mouseOver: AppColors.white.withOpacity(.1),
    mouseDown: AppColors.white.withOpacity(.2),
    iconMouseOver: AppColors.white,
    iconMouseDown: AppColors.white.withOpacity(.5));

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: AppColors.white.withOpacity(.5),
  iconMouseOver: AppColors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../components/logo.dart';
import 'animated_circle.dart';

class CenterLogo extends StatelessWidget {
  const CenterLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        AnimatedCircle(
          maxRadius: 140,
          minRadius: 70,
          duration: Duration(milliseconds: 1000),
        ),
        AnimatedCircle(
          maxRadius: 100,
          minRadius: 70,
          duration: Duration(milliseconds: 2000),
        ),
        ShenKuLogo(70),
      ],
    );
  }
}

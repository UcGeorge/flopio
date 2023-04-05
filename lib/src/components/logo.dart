import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/assets.dart';
import '../../app/colors.dart';

const double concentricRatio = 0.83333333333;
const double logoRatio = 0.438;

double innerRadius(double outerRadius) =>
    ((outerRadius * 2) * concentricRatio) / 2;

double logoHeight(double outerRadius) => ((outerRadius * 2) * logoRatio);

class ShenKuLogo extends StatelessWidget {
  const ShenKuLogo(
    this.height, {
    Key? key,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: height,
      backgroundColor: AppColors.purple,
      child: CircleAvatar(
        radius: innerRadius(height),
        backgroundColor: AppColors.thisWhite,
        child: SvgPicture.asset(
          AppSVG.logoTextSvg,
          color: AppColors.dark,
          height: logoHeight(height),
        ),
      ),
    );
  }
}

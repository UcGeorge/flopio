import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          SvgPicture.asset(
            "assets/svg/unhappy-result.svg",
            // ignore: deprecated_member_use
            color: AppColors.thisWhite,
            height: 100,
          )
              .animate()
              .fadeIn(duration: 1.seconds)
              .shake(curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text(
            "No results!",
            textAlign: TextAlign.center,
            style: AppFonts.nunito.copyWith(
              fontSize: 16,
              color: AppColors.thisWhite,
            ),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

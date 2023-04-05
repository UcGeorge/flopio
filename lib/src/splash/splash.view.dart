import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flopio/util/alert.util.dart';
import 'package:flutter/material.dart';

import '../../app/colors.dart';
import 'components/logo.dart';
import 'splash.flow.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key, required this.flow});

  final SplashFlow flow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onDoubleTap: () {
                AlertUtil.showSuccess("Alert test!");
                // context.testAlert();
                // debugPrint("Tap Event");
              },
              child: const CenterLogo(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('Shen-Ku'),
                    FlickerAnimatedText('Loading...'),
                  ],
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

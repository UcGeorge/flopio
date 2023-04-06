import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/app.dart';
import '../../app/colors.dart';
import '../../app/fonts.dart';
import '../../services/storage.service.dart';
import '../../state/navigation.state.dart';
import '../../state/status_bar.state.dart';
import '../../util/alert.util.dart';
import '../../util/flow.util.dart';
import 'splash.view.dart';

class SplashFlow {
  static void start(BuildContext context) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      page: SplashView(
        flow: SplashFlow()..init(context),
      ),
    );
  }

  Future<void> init(BuildContext context) async {
    await Future.delayed(3.seconds);
    final bool storageIsInitialised = await StorageService.init(
      onError: (error) => AlertUtil.showError(error),
    );

    if (!storageIsInitialised) {
      AlertUtil.showError("Failed to initialize storage!");
      return;
    }

    _addPathToStatusBar();
    _goToHome(context);
  }

  void _goToHome(BuildContext context) {
    AlertUtil.showSuccess("Initialization complete!");
    NavigationState.state.value.resume(context);
    // HomeFlow().resume(context);
  }

  void _addPathToStatusBar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    StatusBarState.addlItem(
      'cwd',
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Text(
          Directory(AppInfo.appDir(appDocDir.path)).absolute.path,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.nunito.copyWith(
            fontSize: 11,
            color: AppColors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../app/colors.dart';
import 'actions/dispatcher.dart';
import 'actions/navigation.dart';
import 'components/shen_status_bar.dart';
import 'components/title_bar.dart';
import 'intents/intents.dart';
import 'scene/scene.view.dart';
import 'shortcuts/logging_shortcut_manager.dart';
import 'shortcuts/navigation.dart';

class ShenScaffold extends StatelessWidget {
  const ShenScaffold({Key? key, required this.body, this.startExpanded})
      : super(key: key);

  final Widget body;
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return LoggedShortcuts(
      shortcuts: shenScaffoldNavigation,
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>>{
          BackIntent: GoBackAction(context),
          FowardIntent: GoFowardAction(context),
        },
        child: Builder(
          builder: (context) {
            return WindowBorder(
              color: AppColors.dark,
              child: Material(
                color: AppColors.dark,
                child: Column(
                  children: [
                    const TitleBar(),
                    SceneView(startExpanded: startExpanded, body: body),
                    const ShenStatusBar(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

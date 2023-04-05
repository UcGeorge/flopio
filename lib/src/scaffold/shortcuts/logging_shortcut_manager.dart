import 'package:flutter/material.dart';

import '../../../util/log.util.dart';

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      LogUtil.devLog("<<SHORTCUT>>",
          message: 'Handled shortcut $event in $context');
    } else {
      LogUtil.devLog("<<SHORTCUT>>",
          message: 'Unable to handle shortcut $event in $context');
    }
    return result;
  }
}

class LoggedShortcuts extends Shortcuts {
  const LoggedShortcuts({
    super.key,
    required Map<LogicalKeySet, Intent> shortcuts,
    required Widget child,
  }) : super(
          shortcuts: shortcuts,
          child: child,
        );

  @override
  ShortcutManager? get manager => LoggingShortcutManager();
}

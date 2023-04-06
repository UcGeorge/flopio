import 'package:flopio/util/log.util.dart';
import 'package:flutter/material.dart';

/// An ActionDispatcher that logs all the actions that it invokes.
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    LogUtil.devLog(
      "LoggingActionDispatcher",
      message: 'Action invoked: $action($intent) from $context',
    );
    return super.invokeAction(action, intent, context);
  }
}

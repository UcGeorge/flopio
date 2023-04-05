import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final _log = Logger('<<ACTION>>');

/// An ActionDispatcher that logs all the actions that it invokes.
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    _log.info('Action invoked: $action($intent) from $context');
    return super.invokeAction(action, intent, context);
  }
}

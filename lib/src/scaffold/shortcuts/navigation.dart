import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../intents/intents.dart';

final shenScaffoldNavigation = <LogicalKeySet, Intent>{
  LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD):
      const FowardIntent(),
  LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
      const BackIntent(),
};

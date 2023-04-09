import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/resumable_flow.dart';
import '../../util/flow.util.dart';
import 'library.view.dart';

class LibraryFlow extends ResumableFlow {
  @override
  String get flowName => "library";

  @override
  void resume(BuildContext context, [bool startExpanded = false]) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      transition: FlowTransition.fade,
      transitionDuration: 300.ms,
      page: LibraryPage(),
    );
  }
}

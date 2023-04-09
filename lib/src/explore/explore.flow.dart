import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/resumable_flow.dart';
import '../../util/flow.util.dart';
import 'explore.view.dart';

class ExploreFlow extends ResumableFlow {
  @override
  String get flowName => "explore";

  @override
  void resume(BuildContext context, [bool startExpanded = false]) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      transition: FlowTransition.fade,
      transitionDuration: 300.ms,
      page: ExploreView(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/app.dart';
import '../../app/resumable_flow.dart';
import '../../app/streamed_value.dart';
import '../../data/models/app_data.dart';
import '../../data/models/book.dart';
import '../../state/app.state.dart';
import '../../util/flow.util.dart';
import '../../util/log.util.dart';
import '../drawer/services/drawer.service.dart';
import 'home.view.dart';

class HomeFlow extends ResumableFlow {
  late StreamSubscription appStateStreamSubscription;
  final StreamedValue<List<Book>> library =
      StreamedValue<List<Book>>(initialValue: []);

  final StreamedValue<Map<String, List<Book>>> sourcesHomepage =
      StreamedValue<Map<String, List<Book>>>(initialValue: {});

  @override
  String get flowName => "home";

  @override
  void resume(BuildContext context, [bool startExpanded = false]) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      transition: FlowTransition.fade,
      transitionDuration: 300.ms,
      page: HomePage(
        flow: this..init(),
      ),
    );
  }

  void goToLibrary(BuildContext context) =>
      DrawerService.goToLibrary(context, false);

  void init() {
    library.update(AppState.state.value.library);

    appStateStreamSubscription = AppState.state.stream.listen(_updateLibrary);

    for (var source in AppInfo.appBookSources) {
      final key = source.name;

      if (sourcesHomepage.value.containsKey(key) &&
          sourcesHomepage.value[key]!.isNotEmpty) continue;

      LogUtil.devLog(
        "HomeFlow.init()",
        message: 'Getting $key homepage',
      );

      sourcesHomepage.mutate((state) => state[key] = []);

      source.getHomePage().then(
        (value) {
          if (value.isEmpty) {
            sourcesHomepage.mutate((state) => state.remove(key));
          } else {
            sourcesHomepage.mutate((state) => state[key] = value);
          }
        },
      );
    }
  }

  void dispose() {
    appStateStreamSubscription.cancel();
    // library.dispose();
    // sourcesHomepage.dispose();
  }

  void _updateLibrary(AppData event) => library.update(event.library);
}

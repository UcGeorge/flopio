import 'package:flutter/material.dart';

import '../../../state/navigation.state.dart';
import '../../explore/explore.flow.dart';
import '../../home/home.flow.dart';
import '../../library/library.flow.dart';

class DrawerService {
  static void goToHome(BuildContext context) {
    _push();
    NavigationState.state.update(HomeFlow()..resume(context, true));
  }

  static void goToExplore(BuildContext context) {
    _push();
    NavigationState.state.update(ExploreFlow()..resume(context, true));
  }

  static void goToLibrary(BuildContext context) {
    _push();
    NavigationState.state.update(LibraryFlow()..resume(context, true));
  }

  static void _push() {
    NavigationState.fowardStack.update([]);
    NavigationState.backwardStack
        .mutate((state) => state.add(NavigationState.state.value));
  }
}

import 'package:flutter/material.dart';

import '../../../data/models/book.dart';
import '../../../state/navigation.state.dart';
import '../../explore/explore.flow.dart';
import '../../home/home.flow.dart';
import '../../library/library.flow.dart';
import '../../see_all/see_all.flow.dart';

class DrawerService {
  static void goToHome(BuildContext context, [bool startExpanded = true]) {
    _push();
    NavigationState.state.update(
      HomeFlow()..resume(context, startExpanded),
      tag: "DrawerService.goToHome()",
      message: (state) => "NavigationState: ${state.flowName}",
    );
  }

  static void goToExplore(BuildContext context, [bool startExpanded = true]) {
    _push();
    NavigationState.state.update(
      ExploreFlow()..resume(context, startExpanded),
      tag: "DrawerService.goToExplore()",
      message: (state) => "NavigationState: ${state.flowName}",
    );
  }

  static void goToLibrary(BuildContext context, [bool startExpanded = true]) {
    _push();
    NavigationState.state.update(
      LibraryFlow()..resume(context, startExpanded),
      tag: "DrawerService.goToLibrary()",
      message: (state) => "NavigationState: ${state.flowName}",
    );
  }

  static void goToSeeAll(
    BuildContext context, {
    bool startExpanded = true,
    required List<Book> books,
    required String sectionName,
  }) {
    _push();
    NavigationState.state.update(SeeAllFlow(
      books: books,
      sectionName: sectionName,
    )..resume(context));
  }

  static void _push() {
    NavigationState.fowardStack.update(
      [],
      tag: "DrawerService._push()",
      message: (state) =>
          "NavigationState.fowardStack: ${state.map((e) => e.flowName).toList()}",
    );
    NavigationState.backwardStack.mutate(
      (state) => state.add(NavigationState.state.value),
      tag: "DrawerService._push()",
      message: (state) =>
          "NavigationState.backwardStack: ${state.map((e) => e.flowName).toList()}",
    );
  }
}

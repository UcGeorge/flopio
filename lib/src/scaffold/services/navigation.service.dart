import 'package:flutter/material.dart';

import '../../../state/navigation.state.dart';

class NavigationService {
  static void goBack(BuildContext context) {
    NavigationState.fowardStack.mutate(
      (state) => state.add(NavigationState.state.value),
      tag: "NavigationService.goBack()",
      message: (state) =>
          "NavigationState.fowardStack: ${state.map((e) => e.flowName).toList()}",
    );
    NavigationState.state.update(
      NavigationState.backwardStack.value.last..resume(context),
      tag: "NavigationService.goBack()",
      message: (state) => "NavigationState: ${state.flowName}",
    );
    NavigationState.backwardStack.mutate(
      (state) => state.removeLast(),
      tag: "NavigationService.goBack()",
      message: (state) =>
          "NavigationState.backwardStack: ${state.map((e) => e.flowName).toList()}",
    );
  }

  static void goFoward(BuildContext context) {
    NavigationState.backwardStack.mutate(
      (state) => state.add(NavigationState.state.value),
      tag: "NavigationService.goFoward()",
      message: (state) =>
          "NavigationState.backwardStack: ${state.map((e) => e.flowName).toList()}",
    );
    NavigationState.state.update(
      NavigationState.fowardStack.value.last..resume(context),
      tag: "NavigationService.goFoward()",
      message: (state) => "NavigationState: ${state.flowName}",
    );
    NavigationState.fowardStack.mutate(
      (state) => state.removeLast(),
      tag: "NavigationService.goFoward()",
      message: (state) =>
          "NavigationState.fowardStack: ${state.map((e) => e.flowName).toList()}",
    );
  }
}

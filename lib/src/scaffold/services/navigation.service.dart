import 'package:flutter/material.dart';

import '../../../state/navigation.state.dart';

class NavigationService {
  static void goBack(BuildContext context) {
    NavigationState.fowardStack
        .mutate((state) => state.add(NavigationState.state.value));
    NavigationState.state
        .update(NavigationState.backwardStack.value.last..resume(context));
    NavigationState.backwardStack.mutate((state) => state.removeLast());
  }

  static void goFoward(BuildContext context) {
    NavigationState.backwardStack
        .mutate((state) => state.add(NavigationState.state.value));
    NavigationState.state
        .update(NavigationState.fowardStack.value.last..resume(context));
    NavigationState.fowardStack.mutate((state) => state.removeLast());
  }
}

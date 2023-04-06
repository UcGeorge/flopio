import 'package:flutter/material.dart';

import '../../../state/navigation.state.dart';
import '../intents/intents.dart';
import '../services/navigation.service.dart';

class GoBackAction extends Action<BackIntent> {
  GoBackAction(this.context);

  final BuildContext context;

  // @override
  // Object? invoke(covariant BackIntent intent) {
  //   state.isStateless
  //       ? context.navigator.goBackwardWithoutState(context)
  //       : context.navigator.goBackward(context);

  //   return null;
  // }

  @override
  Object? invoke(covariant BackIntent intent) {
    NavigationService.goBack(context);

    return null;
  }

  @override
  bool get isActionEnabled => NavigationState.backwardStack.value.isNotEmpty;

  @override
  bool isEnabled(BackIntent intent) => isActionEnabled;
}

class GoFowardAction extends Action<FowardIntent> {
  GoFowardAction(this.context);

  final BuildContext context;

  @override
  Object? invoke(covariant FowardIntent intent) {
    NavigationService.goFoward(context);
    return null;
  }

  @override
  bool get isActionEnabled => NavigationState.fowardStack.value.isNotEmpty;

  @override
  bool isEnabled(FowardIntent intent) => isActionEnabled;
}

import 'package:flutter/material.dart';

import '../../../app/resumable_flow.dart';
import '../../../state/navigation.state.dart';
import '../intents/intents.dart';
import 'shen_nav_button.dart';

class NavButtons extends StatelessWidget {
  const NavButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResumableFlow>(
      stream: NavigationState.state.stream,
      initialData: NavigationState.state.value,
      builder: (context, snapshot) {
        return Row(
          children: [
            ShenNavButton(
              enabled: NavigationState.backwardStack.value.length > 1,
              onTap: () =>
                  Actions.maybeInvoke<BackIntent>(context, const BackIntent()),
            ),
            const SizedBox(width: 4),
            ShenNavButton(
              quarterTurns: 2,
              enabled: NavigationState.fowardStack.value.length > 1,
              onTap: () => Actions.maybeInvoke<FowardIntent>(
                  context, const FowardIntent()),
            )
          ],
        );
      },
    );
  }
}

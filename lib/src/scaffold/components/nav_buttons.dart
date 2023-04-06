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
    return Row(
      children: [
        StreamBuilder<List<ResumableFlow>>(
            stream: NavigationState.backwardStack.stream,
            initialData: NavigationState.backwardStack.value,
            builder: (context, snapshot) {
              return ShenNavButton(
                enabled: snapshot.data!.isNotEmpty,
                onTap: () => Actions.maybeInvoke<BackIntent>(
                  context,
                  const BackIntent(),
                ),
              );
            }),
        const SizedBox(width: 4),
        StreamBuilder<List<ResumableFlow>>(
          stream: NavigationState.fowardStack.stream,
          initialData: NavigationState.fowardStack.value,
          builder: (context, snapshot) {
            return ShenNavButton(
              quarterTurns: 2,
              enabled: snapshot.data!.isNotEmpty,
              onTap: () => Actions.maybeInvoke<FowardIntent>(
                context,
                const FowardIntent(),
              ),
            );
          },
        )
      ],
    );
  }
}

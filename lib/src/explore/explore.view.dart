import 'package:flutter/material.dart';

import '../scaffold/scaffold.view.dart';

class ExploreView extends StatelessWidget {
  ExploreView({Key? key, this.startExpanded}) : super(key: key);

  final ScrollController controller = ScrollController();
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: startExpanded,
      body: const Placeholder(),
    );
  }
}

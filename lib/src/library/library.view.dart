import 'package:flutter/material.dart';

import '../../data/models/app_data.dart';
import '../../state/app.state.dart';
import '../components/smooth_scroll.dart';
import '../home/components/book_section.dart';
import '../scaffold/scaffold.view.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key, this.startExpanded}) : super(key: key);

  final ScrollController controller = ScrollController();
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: startExpanded,
      body: StreamBuilder<AppData>(
        stream: AppState.state.stream,
        initialData: AppState.state.value,
        builder: (context, snapshot) {
          final state = snapshot.data!;
          return SmoothScrollView(
            controller: controller,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                BookSection(
                  title: 'Library',
                  books: state.library,
                  overrideSeeAll: () {},
                  cap: state.library.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

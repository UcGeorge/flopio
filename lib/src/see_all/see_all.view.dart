import 'package:flutter/material.dart';

import '../components/smooth_scroll.dart';
import '../home/components/book_section.dart';
import '../scaffold/scaffold.view.dart';
import 'see_all.flow.dart';

class SeeAllPage extends StatelessWidget {
  SeeAllPage({
    Key? key,
    required this.flow,
  }) : super(key: key);

  final ScrollController controller = ScrollController();
  final SeeAllFlow flow;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: false,
      body: SmoothScrollView(
        controller: controller,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            BookSection(
              title: flow.sectionName,
              books: flow.books,
              cap: flow.books.length,
            ),
          ],
        ),
      ),
    );
  }
}

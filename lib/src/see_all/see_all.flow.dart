import 'package:flutter/material.dart';

import '../../app/resumable_flow.dart';
import '../../data/models/book.dart';
import '../../util/flow.util.dart';
import 'see_all.view.dart';

class SeeAllFlow extends ResumableFlow {
  SeeAllFlow({
    required this.books,
    required this.sectionName,
  });

  final List<Book> books;
  final String sectionName;

  @override
  String get flowName => sectionName;

  @override
  void resume(BuildContext context) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      transition: FlowTransition.fade,
      page: SeeAllPage(
        flow: this,
      ),
    );
  }
}

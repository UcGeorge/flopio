import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/app.dart';
import '../../app/resumable_flow.dart';
import '../../app/source.dart';
import '../../app/streamed_value.dart';
import '../../data/models/book.dart';
import '../../util/flow.util.dart';
import '../../util/log.util.dart';
import 'explore.view.dart';

class ExploreFlow extends ResumableFlow {
  final StreamedValue<bool> searchLoading =
      StreamedValue<bool>(initialValue: false);

  final StreamedValue<Map<BookSource, List<Book>>> searchResults =
      StreamedValue<Map<BookSource, List<Book>>>(initialValue: {});

  final StreamedValue<String?> searchString =
      StreamedValue<String?>(initialValue: null);

  final TextEditingController searchTextController = TextEditingController();

  @override
  String get flowName => "explore";

  @override
  void resume(BuildContext context, [bool startExpanded = false]) {
    FlowUtil.moveToAndRemoveAll(
      context: context,
      transition: FlowTransition.fade,
      transitionDuration: 300.ms,
      page: ExploreView(
        flow: this,
        startExpanded: startExpanded,
      ),
    );
  }

  Future<void> search() async {
    if (searchTerm.isEmpty) return;

    searchLoading.update(true);
    searchString.update(searchTerm);

    for (BookSource source in AppInfo.appBookSources) {
      final key = source.name;

      LogUtil.devLog(
        "ExploreFlow.search()",
        message: 'Searching for ${searchString.value} in $key',
      );

      try {
        final results = await source.search(searchString.value!);

        if (results.isEmpty) continue;
        searchResults.mutate((state) => state[source] = results);
      } catch (e) {
        continue;
      }
    }
    searchLoading.update(false);
  }

  String get searchTerm => searchTextController.value.text.trim();
}

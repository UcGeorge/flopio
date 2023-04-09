import 'package:flutter/material.dart';

import '../../app/source.dart';
import '../../data/models/book.dart';
import '../../util/string.util.dart';
import '../components/smooth_scroll.dart';
import '../home/components/book_section.dart';
import '../scaffold/scaffold.view.dart';
import 'components/no_results.dart';
import 'components/search_field.dart';
import 'explore.flow.dart';

class ExploreView extends StatelessWidget {
  ExploreView({Key? key, this.startExpanded, required this.flow})
      : super(key: key);

  final ScrollController controller = ScrollController();
  final ExploreFlow flow;
  final bool? startExpanded;

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: startExpanded,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTextField(flow: flow),
          const SizedBox(height: 16),
          StreamBuilder<Map<BookSource, List<Book>>>(
            stream: flow.searchResults.stream,
            initialData: flow.searchResults.value,
            builder: (context, snapshot) {
              final bookSectionTitles = snapshot.data!.keys.toList();
              final bookSectionBooks = snapshot.data!.values.toList();

              List<Widget> bookSections = <Widget>[];

              bookSectionTitles.iterate(
                (element, index) {
                  bookSections.add(BookSection(
                    books: bookSectionBooks[index],
                    title:
                        "${element.name.capitalize}: ${flow.searchString.value}",
                  ));
                },
              );

              return Expanded(
                child: StreamBuilder<bool>(
                  stream: flow.searchLoading.stream,
                  initialData: flow.searchLoading.value,
                  builder: (context, snapshot) {
                    final isDoneLoading = !(snapshot.data!);
                    final noResults = isDoneLoading &&
                        bookSections.isEmpty &&
                        (flow.searchString.value?.isNotEmpty ?? false);

                    return noResults
                        ? const NoResultsWidget()
                        : SmoothScrollView(
                            controller: controller,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller,
                              children: bookSections,
                            ),
                          );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/source.dart';
import '../../data/models/book.dart';
import '../components/smooth_scroll.dart';
import '../scaffold/scaffold.view.dart';
import 'components/book_section.dart';
import 'home.flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    this.startExpanded,
    required this.flow,
  }) : super(key: key);

  final HomeFlow flow;
  final bool? startExpanded;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    widget.flow.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShenScaffold(
      startExpanded: widget.startExpanded,
      body: StreamBuilder<List<Book>>(
        stream: widget.flow.library.stream,
        initialData: widget.flow.library.value,
        builder: (context, librarySnapshot) {
          return StreamBuilder<Map<String, List<Book>>>(
            stream: widget.flow.sourcesHomepage.stream,
            initialData: widget.flow.sourcesHomepage.value,
            builder: (_, sourcesSnapshot) {
              final library = librarySnapshot.data!;
              final sourcesHomepage = sourcesSnapshot.data!;

              final bookSectionTitles = sourcesHomepage.keys.toList();
              final bookSectionBooks = sourcesHomepage.values.toList();

              List bookSections = [];

              bookSectionTitles.iterate(
                (element, index) {
                  bookSections.add(BookSection(
                    books: bookSectionBooks[index],
                    title: element,
                  ));
                },
              );

              return SmoothScrollView(
                controller: controller,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    BookSection(
                      title: 'Library',
                      books: library,
                      cap: 5,
                      overrideSeeAll: () => widget.flow.goToLibrary(context),
                    ),
                    ...bookSections,
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../data/models/book.dart';
import '../../data/models/app_data.dart';
import '../../state/app.state.dart';
import '../../state/book.state.dart';
import 'book.flow.dart';
import 'components/close_button.dart';
import 'components/content.dart';
import 'components/cover_photo.dart';
import 'components/name.dart';
import 'components/view_extensions.dart';

class BookDetailsView extends StatelessWidget {
  BookDetailsView({Key? key, required this.flow}) : super(key: key);

  final ScrollController controller = ScrollController();
  final BookFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Book?>(
      stream: BookState.state.stream,
      initialData: BookState.state.value,
      builder: (context, state) {
        final book = state.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DVCloseButton(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CoverPhoto(book: book),
                    Expanded(
                      child: StreamBuilder<AppData>(
                        stream: AppState.state.stream,
                        initialData: AppState.state.value,
                        builder: (context, snapshot) {
                          final appState = snapshot.data!;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bookname(
                                book: book,
                              ),
                              const SizedBox(height: 2),
                              Wrap(
                                runSpacing: 4,
                                spacing: 4,
                                children: [
                                  if (!appState.library.contains(book))
                                    buildAddButton(book),
                                  if (appState.history.containsKey(book.id) &&
                                      appState.history[book.id]!.chapterHistory
                                          .containsKey(appState
                                              .history[book.id]!
                                              .lastReadChapterId))
                                    buildResumeButton(
                                      context,
                                      book,
                                      appState
                                          .history[book.id]!.lastReadChapterId,
                                      appState
                                          .history[book.id]!
                                          .chapterHistory[appState
                                              .history[book.id]!
                                              .lastReadChapterId]!
                                          .position,
                                    ),
                                  if (!appState.history.containsKey(book.id) &&
                                      book.chapters != null &&
                                      book.chapters!.isNotEmpty)
                                    buildStartButton(context, book),
                                  if (appState.library.contains(book))
                                    buildRemoveButton(book),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BookContent(
              controller: controller,
              book: book,
              flow: flow,
            ),
          ],
        );
      },
    );
  }
}

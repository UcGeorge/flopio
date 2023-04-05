import 'package:flutter/material.dart';

import '../../app/streamed_value.dart';
import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import '../../services/history.service.dart';
import '../../state/reading.state.dart';
import '../../state/status_bar.state.dart';
import '../../util/flow.util.dart';
import 'chapter.view.dart';
import 'components/progress_indicator.dart';

class ChapterFlow {
  ChapterFlow() : book = ReadingState.state.value!;

  final Book book;
  final StreamedValue<Chapter?> chapter =
      StreamedValue<Chapter?>(initialValue: null);

  Set<int> loadedUnits = {};

  void init() {
    final chapterId = ReadingState.chapterIdState.value!;

    chapter.update(
        book.chapters!.firstWhere((element) => element.id == chapterId));

    ReadingState.chapterIdState.stream.listen(_updateChapterState);
  }

  void previousChapter() {
    loadedUnits.clear();
    ReadingState.scrollController.jumpTo(0);
    StatusBarState.removerItem('chapter-load-progress');

    final nextChapterId =
        book.chapters![book.chapters!.indexOf(chapter.value!) + 1].id;

    HistoryService.removeFromHistory(
      bookId: book.id,
      chapterId: chapter.value!.id,
      addChapterId: nextChapterId,
    );

    ReadingState.chapterIdState.update(nextChapterId);
  }

  void nextChapter() {
    loadedUnits.clear();
    ReadingState.scrollController.jumpTo(0);
    StatusBarState.removerItem('chapter-load-progress');

    final nextChapterId =
        book.chapters![book.chapters!.indexOf(chapter.value!) - 1].id;

    HistoryService.removeFromHistory(
      bookId: book.id,
      chapterId: chapter.value!.id,
      addChapterId: nextChapterId,
    );

    ReadingState.chapterIdState.update(nextChapterId);
  }

  void closeChapter(BuildContext context) {
    if (chapter.value == null) return;

    HistoryService.addToHistory(
      bookId: book.id,
      chapterId: chapter.value!.id,
      pageNumber: 1,
      position: 0,
    );

    StatusBarState.removerItem('chapter-load-progress');

    FlowUtil.back(context: context);

    ReadingState.chapterIdState.update(null);
    ReadingState.state.update(null);
  }

  void updateLoadProgressState(Set<int> loadedUnits) {
    StatusBarState.update(
      'chapter-load-progress',
      ChapterProgressIndicator(
        book: book,
        chapter: chapter.value!,
        loadedUnits: loadedUnits,
      ),
    );
  }

  static void start(BuildContext context) {
    FlowUtil.moveTo(
      context: context,
      page: ChapterView(
        flow: ChapterFlow()..init(),
      ),
      transition: FlowTransition.slide,
    );
  }

  void _updateChapterState(String? chapterId) {
    if (ReadingState.state.value != book) return;

    chapter.update(
        book.chapters!.firstWhere((element) => element.id == chapterId));
  }
}

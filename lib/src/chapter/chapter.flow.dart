import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../app/source.dart';
import '../../app/streamed_value.dart';
import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import '../../services/history.service.dart';
import '../../state/app.state.dart';
import '../../state/reading.state.dart';
import '../../state/status_bar.state.dart';
import '../../util/flow.util.dart';
import '../../util/log.util.dart';
import '../book/extensions/source.dart';
import 'chapter.view.dart';
import 'components/progress_indicator.dart';

class ChapterFlow {
  ChapterFlow()
      : book = ReadingState.state.value!,
        chapter = StreamedValue<Chapter>(
            initialValue: ReadingState.state.value!.chapters!.firstWhere(
                (element) => element.id == ReadingState.chapterIdState.value!));

  final Book book;
  final StreamedValue<Chapter> chapter;
  late StreamSubscription chapterIdStateStreamSubscription;
  Set<int> loadedUnits = {};

  void init() {
    chapterIdStateStreamSubscription =
        ReadingState.chapterIdState.stream.listen(_updateChapterState);

    _getChapterDetails();
  }

  void previousChapter() {
    loadedUnits.clear();
    ReadingState.scrollController.jumpTo(0);
    StatusBarState.removerItem('chapter-load-progress');

    final nextChapterId =
        book.chapters![book.chapters!.indexOf(chapter.value) + 1].id;

    HistoryService.removeFromHistory(
      bookId: book.id,
      chapterId: chapter.value.id,
      addChapterId: nextChapterId,
    );

    ReadingState.chapterIdState.update(nextChapterId);
  }

  void nextChapter() {
    loadedUnits.clear();
    ReadingState.scrollController.jumpTo(0);
    StatusBarState.removerItem('chapter-load-progress');

    final nextChapterId =
        book.chapters![book.chapters!.indexOf(chapter.value) - 1].id;

    HistoryService.removeFromHistory(
      bookId: book.id,
      chapterId: chapter.value.id,
      addChapterId: nextChapterId,
    );

    ReadingState.chapterIdState.update(nextChapterId);
  }

  void closeChapter(BuildContext context) {
    HistoryService.addToHistory(
      bookId: book.id,
      chapterId: chapter.value.id,
      pageNumber: 1,
      position: 0,
    );

    StatusBarState.removerItem('chapter-load-progress');

    FlowUtil.back(context: context);

    ReadingState.chapterIdState.update(null);
    ReadingState.state.update(null);
  }

  void updateLoadProgressState(Set<int> loadedUnits) {
    StatusBarState.updater(
      'chapter-load-progress',
      ChapterProgressIndicator(
        book: book,
        chapter: chapter.value,
        loadedUnits: loadedUnits,
      ),
    );
  }

  void dispose() {
    chapterIdStateStreamSubscription.cancel();
    chapter.dispose();
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

  Future<void> _getChapterDetails() async {
    final chapter = this.chapter.value;

    LogUtil.devLog(
      "ChapterFlow._getChapterDetails()",
      message: 'Getting chapter details for ${book.name} / ${chapter.name}',
    );

    BookSource source = AppInfo.appBookSources.getSource(book.source);

    late Chapter updatedChapter;

    if (!chapter.hasContent(book.type)) {
      updatedChapter = await source.getBookChapterDetails(chapter);
    } else {
      return;
    }

    if (updatedChapter.id == ReadingState.chapterIdState.value) {
      LogUtil.devLog(
        "ChapterFlow._getChapterDetails()",
        message: 'Got chapter details for ${book.name} / ${chapter.name}',
      );

      final chapterIndex = book.chapters!.indexOf(updatedChapter);
      book.chapters![chapterIndex] = updatedChapter;

      this.chapter.update(updatedChapter);
    }

    final bookInLibrary = AppState.state.value.library.contains(book);
    if (bookInLibrary) {
      AppState.mutate((state) {
        state.library
          ..remove(book)
          ..insert(0, book);
      });
    }
  }

  void _updateChapterState(String? chapterId) {
    if (ReadingState.state.value != book) return;

    chapter.update(
        book.chapters!.firstWhere((element) => element.id == chapterId));

    _getChapterDetails();
  }
}

import 'package:flopio/state/update.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/app.dart';
import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import '../../state/app.state.dart';
import '../../state/book.state.dart';
import '../../state/reading.state.dart';
import '../../util/log.util.dart';
import '../chapter/chapter.flow.dart';
import 'extensions/source.dart';

class BookFlow {
  static void start(Book book) {
    BookState.state.update(book);
    BookState.newStateCount.mutate((state) => state += 1);
  }

  void init() async {
    final book = BookState.state.value;

    if (book == null) return;
    // if (book.hasCompleteData) return;

    final DateTime? lastUpdateTime = UpdateState.updateLog.value[book];

    if (lastUpdateTime != null &&
        DateTime.now().difference(lastUpdateTime) < 1.minutes) return;

    LogUtil.devLog(
      "BookFlow.init()",
      message: 'Getting book details for ${book.name}',
    );

    String source = book.source;

    Book detailedBook = book.merge(
      await AppInfo.appBookSources.getSource(source).getBookDetails(
            book,
            fields: book.missingFields,
          ),
      fields: book.missingFields,
    );

    if (BookState.state.value == detailedBook) {
      BookState.state.update(detailedBook);
    }

    final bookInLibrary = AppState.state.value.library.contains(detailedBook);

    if (bookInLibrary) {
      AppState.mutate((state) {
        state.library
          ..remove(book)
          ..insert(0, detailedBook);
      });

      UpdateState.updateLog.mutate((state) => state.update(
            book,
            (value) => DateTime.now(),
            ifAbsent: () => DateTime.now(),
          ));
    }
  }

  void showChapter(BuildContext context, Chapter chapter) {
    final book = BookState.state.value;

    if (book == null) return;

    LogUtil.devLog(
      "BookFlow.showChapter()",
      message: 'Reading chapter ${book.name} / ${chapter.name}',
    );

    _setReadingState(book, chapter.id);

    ChapterFlow.start(context);
  }

  void startBook(BuildContext context) {
    final book = BookState.state.value;

    if (book == null) return;

    final chapter = book.chapters!.last;

    LogUtil.devLog(
      "BookFlow.startBook()",
      message: 'Starting book ${book.name}',
    );

    _setReadingState(book, chapter.id);

    ChapterFlow.start(context);
  }

  void resumeBook(BuildContext context) {
    final book = BookState.state.value;

    if (book == null) return;

    final chapterId = AppState.state.value.history[book.id]!.lastReadChapterId;

    // final readingOffset = AppState
    //     .state
    //     .value
    //     .history[book.id]!
    //     .chapterHistory[
    //         AppState.state.value.history[book.id]!.lastReadChapterId]!
    //     .position;

    LogUtil.devLog(
      "BookFlow.resumeBook()",
      message: 'Resuming book ${book.name}',
    );

    _setReadingState(book, chapterId);

    ChapterFlow.start(context);
  }

  void _setReadingState(Book book, String chapterId) {
    ReadingState.state.update(book);
    ReadingState.chapterIdState.update(chapterId);
  }
}

import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import '../../state/app.state.dart';
import '../../state/book.state.dart';
import '../../state/reading.state.dart';
import '../../util/log.util.dart';
import '../chapter/chapter.flow.dart';

class BookFlow {
  void _setReadingState(Book book, String chapterId) {
    ReadingState.state.update(book);
    ReadingState.chapterIdState.update(chapterId);
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
}

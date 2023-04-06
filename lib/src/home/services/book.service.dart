import 'package:flutter/material.dart';

import '../../../data/models/book.dart';
import '../../../state/app.state.dart';
import '../../../state/reading.state.dart';
import '../../../util/log.util.dart';
import '../../chapter/chapter.flow.dart';

class BookService {
  static void startBook(BuildContext context, Book book) {
    final chapter = book.chapters!.last;

    LogUtil.devLog(
      "BookService.startBook()",
      message: 'Starting book ${book.name}',
    );

    _setReadingState(book, chapter.id);

    ChapterFlow.start(context);
  }

  static void resumeBook(BuildContext context, Book book) {
    final chapterId = AppState.state.value.history[book.id]!.lastReadChapterId;

    // final readingOffset = AppState
    //     .state
    //     .value
    //     .history[book.id]!
    //     .chapterHistory[
    //         AppState.state.value.history[book.id]!.lastReadChapterId]!
    //     .position;

    LogUtil.devLog(
      "BookService.resumeBook()",
      message: 'Resuming book ${book.name}',
    );

    _setReadingState(book, chapterId);

    ChapterFlow.start(context);
  }

  static void _setReadingState(Book book, String chapterId) {
    ReadingState.state.update(book);
    ReadingState.chapterIdState.update(chapterId);
  }
}

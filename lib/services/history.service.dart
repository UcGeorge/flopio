import '../data/models/history_item.dart';
import '../state/app.state.dart';
import '../util/log.util.dart';

class HistoryService {
  static Future<void> addToHistory({
    required bookId,
    required chapterId,
    required int pageNumber,
    required double position,
  }) async {
    LogUtil.devLog(
      "HistoryService.addToHistory()",
      message: 'Adding to history: $bookId - $chapterId',
    );
    final chapterHistoryItem = ChapterHistoryItem(
      chapterId: chapterId,
      position: position,
      pageNumber: pageNumber,
    );
    AppState.update(
      (data) => data.copyWith(
        history: data.history
          ..update(
            bookId,
            (value) => value.copyWith(
              lastReadChapterId: chapterId,
              chapterHistory: data.history[bookId]!.chapterHistory
                ..update(
                  chapterId,
                  (value) => chapterHistoryItem,
                  ifAbsent: () => chapterHistoryItem,
                ),
            ),
            ifAbsent: () => BookHistoryItem(
              bookId: bookId,
              lastReadChapterId: chapterId,
              chapterHistory: {chapterId: chapterHistoryItem},
            ),
          ),
      ),
    );
  }

  static Future<void> removeFromHistory({
    required bookId,
    required chapterId,
    String? addChapterId,
  }) async {
    if (!AppState.state.value!.history.containsKey(bookId)) return;
    if (!AppState.state.value!.history[bookId]!.chapterHistory
        .containsKey(chapterId)) {
      return;
    }

    LogUtil.devLog(
      "HistoryService.removeFromHistory()",
      message: 'Removing from history: $bookId - $chapterId',
    );
    AppState.update(
      (data) => data.copyWith(
        history: data.history
          ..update(
            bookId,
            (value) => value.copyWith(
              lastReadChapterId: chapterId,
              chapterHistory: data.history[bookId]!.chapterHistory
                ..remove(chapterId),
            ),
          ),
      ),
    );

    if (AppState.state.value!.history[bookId]!.chapterHistory.isEmpty) {
      AppState.update(
        (data) => data.copyWith(
          history: data.history..remove(bookId),
        ),
      );
    }

    if (addChapterId != null) {
      await addToHistory(
        bookId: bookId,
        chapterId: addChapterId,
        pageNumber: 1,
        position: 0,
      );
    }
  }
}

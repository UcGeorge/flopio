import '../data/models/book.dart';
import '../state/app.state.dart';
import '../util/alert.util.dart';
import '../util/log.util.dart';

class LibraryService {
  static Future<void> addToLibrary(Book book) async {
    LogUtil.devLog(
      "LibraryService.addToLibrary()",
      message: 'Adding to library: ${book.name}',
    );

    if (AppState.state.value.library.contains(book)) {
      LogUtil.devLog(
        "LibraryService.addToLibrary()",
        message: '${book.name} is already in library.',
      );
      AlertUtil.showWarning('${book.name} is already in library.');
      return;
    }

    AppState.update(
      (data) => data.copyWith(
        library: data.library..add(book),
      ),
    );
  }

  static Future<void> removeFromLibrary(Book book) async {
    LogUtil.devLog(
      "LibraryService.removeFromLibrary()",
      message: 'Removing from library: ${book.name}',
    );

    if (!AppState.state.value.library.contains(book)) {
      LogUtil.devLog(
        "LibraryService.addToLibrary()",
        message: '${book.name} is not in library.',
      );
      AlertUtil.showWarning('${book.name} is not in library.');
      return;
    }

    AppState.update(
      (data) => data.copyWith(
        library: data.library..remove(book),
      ),
    );
  }
}

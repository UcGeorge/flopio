import 'package:flutter/material.dart';

import '../../../../data/models/book.dart';
import '../../../app/assets.dart';
import '../../../data/models/app_data.dart';
import '../../../services/library.service.dart';
import '../../../state/app.state.dart';
import '../services/book.service.dart';
import 'rv_context_button.dart';

class BookTileContextButton extends StatelessWidget {
  const BookTileContextButton(this.book, this.context, {Key? key})
      : super(key: key);

  final Book book;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return StreamBuilder<AppData>(
      stream: AppState.state.stream,
      initialData: AppState.state.value,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        bool isInLibrary = state.library.contains(book);
        bool hasChapters = book.chapters?.isNotEmpty ?? false;
        bool isInHistory = hasChapters && state.history.containsKey(book.id);

        return isInLibrary
            ? hasChapters
                ? isInHistory
                    ? RVContextButton(
                        book,
                        fullWidth: 74,
                        icon: AppIcons.startReadingIcon,
                        text: 'Resume',
                        action: (toogleFlag) async =>
                            BookService.resumeBook(context, book),
                      )
                    : RVContextButton(
                        book,
                        fullWidth: 74,
                        icon: AppIcons.startReadingIcon,
                        text: 'Start',
                        action: (toogleFlag) async =>
                            BookService.startBook(context, book),
                      )
                : const SizedBox.shrink()
            : RVContextButton(
                book,
                fullWidth: 70,
                icon: AppIcons.addToLibraryIcon,
                text: 'Library',
                action: (toogleFlag) {
                  toogleFlag();
                  LibraryService.addToLibrary(book);
                  toogleFlag();
                },
              );
      },
    );
  }
}

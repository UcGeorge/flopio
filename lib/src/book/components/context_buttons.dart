import 'package:flutter/material.dart';

import '../../../data/models/book.dart';
import '../../../state/app.state.dart';

class DetailsViewContextButtons extends StatelessWidget {
  const DetailsViewContextButtons(this.book, {Key? key, required this.context})
      : super(key: key);

  final Book book;
  final BuildContext context;

  @override
  Widget build(_) {
    bool isInLibrary = AppState.state.value.library.contains(book);

    return Row(
      children: const [
        // isInLibrary
        //     ? Row(
        //         children: [
        //           // state.book!.lastChapterRead.isEmpty
        //           //     ? DVContextButton(
        //           //         detailsPlaneState,
        //           //         text:
        //           //             'Start: ${detailsPlaneState.readable!.readableDetails!.metaChapters!.last.name}',
        //           //         fullWidth: 165,
        //           //         action: (toogleFlag) async {
        //           //           //TODO: Implement chapters
        //           //         },
        //           //       )
        //           //     : DVContextButton(
        //           //         detailsPlaneState,
        //           //         text:
        //           //             'Continue: ${detailsPlaneState.readable!.lastChapterRead}',
        //           //         fullWidth: 165,
        //           //         action: (toogleFlag) async {
        //           //           //TODO: Implement chapters
        //           //         },
        //           //       ),
        //           const SizedBox(width: 8),
        //           // DVContextButton(
        //           //   icon: Icons.delete,
        //           //   fullWidth: 25,
        //           //   text: '',
        //           //   iconSize: 16,
        //           //   iconButton: true,
        //           //   action: (toogleFlag) async {
        //           //     toogleFlag();
        //           //     context.read<SelectedMenu>().clearDetails();
        //           //     context
        //           //         .read<Database>()
        //           //         .library
        //           //         .delete(context, detailsPlaneState.readable!.id);
        //           //     toogleFlag();
        //           //   },
        //           // ),
        //         ],
        //       )
        //     : DVContextButton(
        //         detailsPlaneState,
        //         text: 'Add to Library',
        //         fullWidth: 150,
        //         action: (toogleFlag) async {
        //           toogleFlag();
        //           detailsPlaneState.readable!
        //               .addToLibrary(context)
        //               .then((value) {
        //             toogleFlag();
        //           }).catchError((e) {
        //             print(e);
        //             toogleFlag();
        //           });
        //         },
        //       ),
        // const Spacer(),
      ],
    );
  }
}

//* MAY BE IMPORTANT LATER
  //* String _hoverText(BuildContext context, Readable readable) {
  //*   if (!context
  //*       .watch<Database>()
  //*       .library
  //*       .contains((element) => element.id == readable.id)) {
  //*     return 'Add to Library';
  //*   } else if (readable.lastChapterRead.isEmpty) {
  //*     return 'Start: ${widget.detailsPlaneState.readable!.readableDetails!.metaChapters!.last.name}';
  //*   } else {
  //*     return 'Continue: ${readable.lastChapterRead}';
  //*   }
  //* }
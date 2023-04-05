import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import '../../../services/library.service.dart';
import '../book.view.dart';

extension Widgets on BookDetailsView {
  ElevatedButton buildResumeButton(
      BuildContext context, Book book, String chapterId, double offset) {
    return ElevatedButton(
      onPressed: () => flow.resumeBook(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: AppColors.white.withOpacity(.8),
            width: 1,
          ),
        ),
      ),
      child: Text(
        'Resume',
        overflow: TextOverflow.ellipsis,
        style: AppFonts.nunito.copyWith(
          fontSize: 14,
          color: AppColors.white,
        ),
      ),
    );
  }

  ElevatedButton buildStartButton(BuildContext context, Book book) {
    return ElevatedButton(
      onPressed: () => flow.startBook(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: AppColors.white.withOpacity(.8),
            width: 1,
          ),
        ),
      ),
      child: Text(
        'Start',
        overflow: TextOverflow.ellipsis,
        style: AppFonts.nunito.copyWith(
          fontSize: 14,
          color: AppColors.white,
        ),
      ),
    );
  }

  ElevatedButton buildAddButton(Book book) {
    return ElevatedButton(
      onPressed: () => LibraryService.addToLibrary(book),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        'Add to Library',
        overflow: TextOverflow.ellipsis,
        style: AppFonts.nunito.copyWith(
          fontSize: 14,
          color: AppColors.white,
        ),
      ),
    );
  }

  ElevatedButton buildRemoveButton(Book book) {
    return ElevatedButton(
      onPressed: () => LibraryService.removeFromLibrary(book),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.zero,
      ),
      child: const Icon(Icons.delete_rounded),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';

class ChapterProgressIndicator extends StatelessWidget {
  const ChapterProgressIndicator({
    super.key,
    required this.loadedUnits,
    required this.chapter,
    required this.book,
  });

  final Book book;
  final Chapter chapter;
  final Set<int> loadedUnits;

  @override
  Widget build(BuildContext context) {
    final isComplete = loadedUnits.length == chapter.contentLength(book.type);

    return chapter.hasContent(book.type)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isComplete)
                  Text(
                    '${loadedUnits.length} / ${chapter.contentLength(book.type)}',
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.nunito.copyWith(
                      fontSize: 11,
                      color: AppColors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                const SizedBox(width: 8),
                isComplete
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 16,
                      )
                    : const CupertinoActivityIndicator(radius: 8),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

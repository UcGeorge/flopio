import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../data/models/book.dart';
import '../../components/image/multi_source_image.dart';

class CoverPhoto extends StatelessWidget {
  const CoverPhoto({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return book.coverPicture == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 200,
                width: 200,
                child: MultiSourceImage(
                  radius: 100,
                  source: book.coverPicture!.source,
                  url: book.coverPicture!.url,
                  backgroundColor: AppColors.thisWhite.withOpacity(.15),
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: false,
                ),
              ),
            ),
          );
  }
}

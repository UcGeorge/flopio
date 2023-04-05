import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import 'context_buttons.dart';
import 'rating_star.dart';

class Bookname extends StatelessWidget {
  const Bookname({super.key, required this.book});

  final Book book;

  TableRow _trRating(BuildContext context) {
    return TableRow(
      children: [
        Text(
          'Rating',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 11,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 1),
        ),
        RatingStar(double.parse(
          book.rating ?? '',
          (source) => 0,
        )),
      ],
    );
  }

  TableRow _trStatus(BuildContext context) {
    return TableRow(
      children: [
        Text(
          'Status',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 11,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1,
              ),
        ),
        Text(
          book.status == BookStatus.completed ? 'Completed' : 'Ongoing',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
              letterSpacing: 1),
        ),
      ],
    );
  }

  TableRow _trSource(BuildContext context) {
    return TableRow(
      children: [
        Text(
          'Source',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 11,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1,
              ),
        ),
        Text(
          book.source,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 11,
                color: AppColors.blueGrey,
                letterSpacing: 1,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.name,
            maxLines: 3,
            overflow: TextOverflow.fade,
            style: AppFonts.nunito.copyWith(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text.rich(
            TextSpan(
              text: book.type == BookType.novel ? 'NOVEL' : 'MANGA',
              children: [
                if (book.chapterCount != null)
                  TextSpan(
                    text: '  •  ${book.chapterCount!} CHAPTERS',
                  ),
              ],
            ),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.5),
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 5),
          Table(
            columnWidths: const {0: FixedColumnWidth(50)},
            children: [
              _trSource(context),
              if (book.status != null) _trStatus(context),
              if (book.rating != null) _trRating(context)
            ],
          ),
          const SizedBox(height: 5),
          DetailsViewContextButtons(
            book,
            context: context,
          )
        ],
      ),
    );
  }
}

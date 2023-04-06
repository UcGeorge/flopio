import 'package:flutter/material.dart';

import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import 'book_tile.dart';
import 'see_more_button.dart';

class BookSection extends StatelessWidget {
  const BookSection({
    Key? key,
    required this.books,
    required this.title,
    this.cap = 10,
    this.overrideSeeAll,
  }) : super(key: key);

  final List<Book> books;
  final int cap;
  final VoidCallback? overrideSeeAll;
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "$title: ${books.length} books";
  }

  Row _buildSectionTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppFonts.nunito.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        const Spacer(),
        (books.length) > cap
            ? SeeMoreButton(
                seeMore: () {},
                books: books,
                title: title,
                overrideSeeAll: overrideSeeAll,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context),
                const SizedBox(height: 15),
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (int i = 0;
                        i < ((books.length) <= cap ? (books.length) : cap);
                        i++)
                      BookTile(book: books[i])
                  ],
                ),
              ],
            ),
          );
  }
}

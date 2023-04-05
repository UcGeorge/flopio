import 'package:flutter/material.dart';

import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import '../../components/smooth_scroll.dart';
import '../book.flow.dart';
import 'chapter_item.dart';

class BookContent extends StatelessWidget {
  const BookContent({
    super.key,
    required this.controller,
    required this.book,
    required this.flow,
  });

  final Book book;
  final ScrollController controller;
  final BookFlow flow;

  List<Widget> _buildDescription(BuildContext context) =>
      book.description == null
          ? []
          : [
              Text(
                'DESCRIPTION',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 1,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                book.description ?? '',
                style: AppFonts.nunito.copyWith(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 20),
            ];

  List<Widget> _buildChapterList(BuildContext context) => book.chapters == null
      ? []
      : [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Text(
              'CHAPTERS',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 1,
                  ),
            ),
          ),
          ...book.chapters!.map((e) => ChapterItem(
                e,
                book,
                flow: flow,
              )),
        ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmoothScrollView(
        controller: controller,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            ..._buildDescription(context),
            ..._buildChapterList(context),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import '../../book/book.flow.dart';
import '../../components/image/multi_source_image.dart';
import 'context_button.dart';

class BookTile extends StatefulWidget {
  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  ClipRRect _buildCoverPicture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: widget.book.coverPicture != null
          ? SizedBox(
              height: 118,
              width: 118,
              child: MultiSourceImage(
                source: widget.book.coverPicture!.source,
                url: widget.book.coverPicture!.url,
                radius: 118 / 2,
                fit: BoxFit.cover,
                errorPlaceholder: Container(
                  height: 118,
                  width: 118,
                  decoration: BoxDecoration(
                    color: AppColors.blueGrey,
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: 118,
              width: 118,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: GestureDetector(
        onTap: () => BookFlow.start(widget.book),
        child: SizedBox(
          width: 146,
          height: 212,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoverPicture(),
                    const SizedBox(height: 8),
                    Text(
                      widget.book.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppFonts.nunito.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.book.type == BookType.manga ? 'Manga' : 'Novel',
                      style: AppFonts.nunito.copyWith(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
              ),
              isHovering
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: BookTileContextButton(widget.book, context),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

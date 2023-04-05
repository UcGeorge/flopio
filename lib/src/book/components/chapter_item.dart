import 'package:flutter/material.dart';

import '../../../../data/models/book.dart';
import '../../../../data/models/chapter.dart';
import '../../../data/models/app_data.dart';
import '../../../state/app.state.dart';
import '../book.flow.dart';

class ChapterItem extends StatefulWidget {
  const ChapterItem(
    this.chapter,
    this.book, {
    Key? key,
    required this.flow,
  }) : super(key: key);

  final Book book;
  final Chapter chapter;
  final BookFlow flow;

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.flow.showChapter(context, widget.chapter),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: _toogleHover,
        onExit: _toogleHover,
        child: Container(
          color: isHovering ? Colors.white.withOpacity(0.05) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.white.withOpacity(0.5),
                height: 1,
                thickness: 0.5,
              ),
              const SizedBox(height: 8),
              StreamBuilder<AppData>(
                stream: AppState.state.stream,
                initialData: AppState.state.value,
                builder: (context, snapshot) {
                  final state = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Text(
                          widget.chapter.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.8),
                                letterSpacing: 1,
                              ),
                        ),
                        const SizedBox(width: 5),
                        if (state.history.containsKey(widget.book.id) &&
                            state.history[widget.book.id]!.chapterHistory
                                .containsKey(widget.chapter.id))
                          Text(
                            '• Page ${state.history[widget.book.id]!.chapterHistory[widget.chapter.id]!.pageNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.3),
                                  letterSpacing: 1,
                                ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

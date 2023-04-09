import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import '../../data/models/chapter.dart';
import '../../state/reading.state.dart';
import '../../util/log.util.dart';
import '../../util/screen.util.dart';
import '../scaffold/components/shen_status_bar.dart';
import 'chapter.flow.dart';
import 'components/chapter_content.dart';
import 'components/nav_buttons.dart';
import 'components/title_bar.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({super.key, required this.flow});

  final ChapterFlow flow;

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  @override
  void dispose() {
    super.dispose();
    widget.flow.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Chapter?>(
      stream: widget.flow.chapter.stream,
      initialData: widget.flow.chapter.value,
      builder: (context, snapshot) {
        final Book book = widget.flow.book;
        final Chapter chapter = snapshot.data!;

        LogUtil.devLog(
          "ChapterView",
          message: 'Building chapter: ${book.name}/${chapter.name}',
        );

        return WindowBorder(
          color: Colors.black,
          child: Material(
            color: Colors.black,
            child: Stack(
              children: [
                SizedBox(
                  height: ScreenUtil.screenSize(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ChapterContent(
                          flow: widget.flow,
                          book: book,
                          chapter: chapter,
                        ),
                      ),
                      const ShenStatusBar(),
                    ],
                  ),
                ),
                TitleBar(flow: widget.flow),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ChapterNavButtons(
                      flow: widget.flow,
                      chapterScrollController: ReadingState.scrollController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

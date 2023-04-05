import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app/colors.dart';
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

class ChapterView extends StatelessWidget {
  const ChapterView({super.key, required this.flow});

  final ChapterFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Chapter?>(
      stream: flow.chapter.stream,
      builder: (context, snapshot) {
        final Book book = flow.book;
        final Chapter? chapter = snapshot.data;

        LogUtil.devLog(
          "ChapterView",
          message: 'Building chapter: ${book.name}/${chapter?.name}',
        );

        return WindowBorder(
          color: Colors.black,
          child: Material(
            color: Colors.black,
            child: chapter == null
                ? Center(
                    child: SpinKitSpinningLines(
                      color: AppColors.violet,
                      size: 50,
                    ),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: ScreenUtil.screenSize(context).height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: ChapterContent(flow: flow)),
                            const ShenStatusBar(),
                          ],
                        ),
                      ),
                      TitleBar(flow: flow),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ChapterNavButtons(
                            flow: flow,
                            chapterScrollController:
                                ReadingState.scrollController,
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

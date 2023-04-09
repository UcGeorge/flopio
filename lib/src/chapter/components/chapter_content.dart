import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../app/colors.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import '../../../state/reading.state.dart';
import '../../components/image/multi_source_image.dart';
import '../chapter.flow.dart';

class ChapterContent extends StatelessWidget {
  const ChapterContent(
      {super.key,
      required this.flow,
      required this.book,
      required this.chapter});

  final ChapterFlow flow;
  final Book book;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    flow.updateLoadProgressState(flow.loadedUnits);

    return chapter.hasContent(book.type)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // width: ScreenUtil.screenSize(context).width >= 802
                //     ? 800
                //     : ScreenUtil.screenSize(context).width - 2,
                constraints: const BoxConstraints(maxWidth: 800),
                color: AppColors.dark,
                child: ListView.builder(
                  // shrinkWrap: true,
                  controller: ReadingState.scrollController,
                  itemCount: chapter.contentLength(book.type),
                  itemBuilder: (_, i) {
                    var type = book.type;
                    return type == BookType.novel
                        ? Container(
                            height: 20,
                            color: Colors.red,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: .5,
                            ),
                          )
                        : MultiSourceImage(
                            shouldRetry: true,
                            source: chapter.chapterImages![i].source,
                            url: chapter.chapterImages![i].url,
                            radius: 20,
                            backgroundColor: AppColors.dark,
                            referer: chapter.link,
                            fit: BoxFit.fitWidth,
                            useOriginalSize: true,
                            onLoadComplete: () {
                              final localChapterId = chapter.id;
                              final remoteChapterId =
                                  ReadingState.chapterIdState.value;
                              // LogUtil.devLog("ChapterView", message: '$localChapterId || $remoteChapterId');
                              if (localChapterId == remoteChapterId) {
                                flow.loadedUnits.add(i);
                                flow.updateLoadProgressState(flow.loadedUnits);
                              }
                            },
                          );
                  },
                ),
              ),
            ],
          )
        : Center(
            child: SpinKitSpinningLines(
              color: AppColors.violet,
              size: 50,
            ),
          );
  }
}

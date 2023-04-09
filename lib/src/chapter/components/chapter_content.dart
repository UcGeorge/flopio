import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/book.dart';
import '../../../data/models/chapter.dart';
import '../../../state/reading.state.dart';
import '../../../util/screen.util.dart';
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
    if (book.type == BookType.manga) {
      flow.updateLoadProgressState(flow.loadedUnits);
    }

    return chapter.hasContent(book.type)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtil.screenSize(context).width >= 802
                    ? 800
                    : ScreenUtil.screenSize(context).width - 2,
                color: AppColors.dark,
                child: ListView.builder(
                  // shrinkWrap: true,
                  controller: ReadingState.scrollController,
                  itemCount: chapter.contentLength(book.type),
                  itemBuilder: (_, i) {
                    var type = book.type;
                    return type == BookType.novel
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              chapter.chapterParagraphs![i],
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.nunito.copyWith(
                                fontSize: 16,
                                color: AppColors.thisWhite.withOpacity(0.7),
                                letterSpacing: 1.5,
                              ),
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

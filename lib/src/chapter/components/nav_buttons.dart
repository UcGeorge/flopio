import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../data/models/chapter.dart';
import '../chapter.flow.dart';
import 'shen_nav_button.dart';
import 'slider.dart';

class ChapterNavButtons extends StatefulWidget {
  const ChapterNavButtons({
    Key? key,
    required this.chapterScrollController,
    required this.flow,
  }) : super(key: key);

  final ScrollController chapterScrollController;
  final ChapterFlow flow;

  @override
  State<ChapterNavButtons> createState() => _ChapterNavButtonsState();
}

class _ChapterNavButtonsState extends State<ChapterNavButtons> {
  bool isHovering = false;

  @override
  void dispose() {
    super.dispose();
    widget.chapterScrollController.removeListener(updateState);
  }

  @override
  void initState() {
    super.initState();
    widget.chapterScrollController.addListener(updateState);
  }

  void updateState() => setState(() {});

  void _toogleHover(bool value) {
    setState(() {
      isHovering = value;
    });
  }

  Container _buildChapterSlider(Chapter chapter) {
    final controller = widget.chapterScrollController;
    final chapterLength = chapter.contentLength(widget.flow.book.type);
    final value = controller.hasClients &&
            controller.position.haveDimensions &&
            controller.position.maxScrollExtent != 0
        ? (controller.offset / controller.position.maxScrollExtent) *
            chapterLength
        : 0;
    return Container(
      height: 40,
      // width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ChapterSlider(
        value: value,
        chapterLength: chapterLength,
        widget: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _toogleHover(true),
      onExit: (_) => _toogleHover(false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isHovering ? 1 : .15,
        child: SizedBox(
          height: 40,
          child: StreamBuilder<Chapter?>(
            stream: widget.flow.chapter.stream,
            initialData: widget.flow.chapter.value,
            builder: (context, snapshot) {
              final chapter = snapshot.data!;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShenChapterNavButton(
                    forward: false,
                    enabled: widget.flow.book.chapters!.last != chapter,
                    onTap: widget.flow.previousChapter,
                  ),
                  _buildChapterSlider(chapter),
                  ShenChapterNavButton(
                    forward: true,
                    enabled: widget.flow.book.chapters!.first != chapter,
                    onTap: widget.flow.nextChapter,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

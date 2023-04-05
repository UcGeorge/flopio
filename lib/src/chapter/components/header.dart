import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../data/models/chapter.dart';
import '../chapter.flow.dart';
import 'close_button.dart';

class ChapterHeader extends StatefulWidget {
  const ChapterHeader({
    Key? key,
    required this.flow,
  }) : super(key: key);

  final ChapterFlow flow;

  @override
  State<ChapterHeader> createState() => _ChapterHeaderState();
}

class _ChapterHeaderState extends State<ChapterHeader> {
  bool isHovering = false;

  void _toogleHover(PointerEvent e) {
    setState(() {
      isHovering = !isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _toogleHover,
      onExit: _toogleHover,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isHovering ? 1 : .15,
        child: Container(
          height: 20,
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.blueGrey,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              ChapterCloseButton(enabled: true, flow: widget.flow),
              const SizedBox(width: 10),
              Expanded(
                child: StreamBuilder<Chapter?>(
                  stream: widget.flow.chapter.stream,
                  initialData: widget.flow.chapter.value,
                  builder: (context, snapshot) {
                    return Text(
                      '${widget.flow.book.name} / ${snapshot.data?.name}',
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.nunito.copyWith(
                          fontSize: 11,
                          color: isHovering
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.5),
                          letterSpacing: 1.5),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

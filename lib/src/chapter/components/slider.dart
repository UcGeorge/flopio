import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import 'nav_buttons.dart';

class ChapterSlider extends StatefulWidget {
  const ChapterSlider({
    Key? key,
    required this.value,
    required this.chapterLength,
    required this.widget,
  }) : super(key: key);

  final int chapterLength;
  final num value;
  final ChapterNavButtons widget;

  @override
  State<ChapterSlider> createState() => _ChapterSliderState();
}

class _ChapterSliderState extends State<ChapterSlider> {
  late num value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toInt().toString(),
          overflow: TextOverflow.ellipsis,
          style: AppFonts.nunito.copyWith(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: widget.chapterLength.toDouble(),
          onChanged: (value_) {
            final controller = widget.widget.chapterScrollController;
            controller.jumpTo((value_ / widget.chapterLength) *
                controller.position.maxScrollExtent);
            setState(() {
              value = value_;
            });
          },
          thumbColor: AppColors.violet,
          activeColor: AppColors.violet.withOpacity(.3),
          inactiveColor: AppColors.white.withOpacity(.3),
        ),
        Text(
          '${widget.chapterLength}',
          overflow: TextOverflow.ellipsis,
          style: AppFonts.nunito.copyWith(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

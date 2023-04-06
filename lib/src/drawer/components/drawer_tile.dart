import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../util/string.util.dart';

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({
    Key? key,
    required this.expanded,
    required this.selected,
    required this.setHoverState,
    required this.onTap,
    required this.iconPath,
    required this.selectedIconPath,
    required this.title,
    required this.hovered,
  }) : super(key: key);

  final bool expanded;
  final bool hovered;
  final String iconPath;
  final VoidCallback onTap;
  final bool selected;
  final String selectedIconPath;
  final Function(String) setHoverState;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) => setHoverState(title),
      onExit: (e) => setHoverState('null'),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 100),
            firstChild: SizedBox(
              height: 36,
              width: double.infinity,
              child: expanded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset(
                            selected ? selectedIconPath : iconPath),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          title.capitalize,
                          style: AppFonts.nunito.copyWith(
                            fontSize: 18,
                            color: selected || hovered
                                ? AppColors.white
                                : AppColors.lessWhite,
                          ),
                        ),
                        const Spacer(),
                        if (selected)
                          Container(
                            height: 36,
                            width: 6,
                            decoration: BoxDecoration(
                              color: AppColors.violet,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            secondChild: SizedBox(
              height: 36,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        selected ? selectedIconPath : iconPath),
                  ),
                  if (selected)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 36,
                        width: 6,
                        decoration: BoxDecoration(
                          color: AppColors.violet,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            crossFadeState:
                expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }
}

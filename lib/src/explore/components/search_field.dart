import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../explore.flow.dart';

final kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100),
  borderSide: BorderSide.none,
);

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.flow,
  });

  final ExploreFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: flow.searchLoading.stream,
      initialData: flow.searchLoading.value,
      builder: (context, snapshot) {
        final isLoading = snapshot.data!;
        return RepaintBoundary(
          child: TextField(
            controller: flow.searchTextController,
            style: AppFonts.nunito.copyWith(
              fontSize: 16,
              color: AppColors.thisWhite,
            ),
            // cursorHeight: 2,
            onSubmitted: (value) => flow.search(),
            textAlignVertical: TextAlignVertical.top,
            cursorColor: AppColors.thisWhite,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.dark.withOpacity(.7),
              constraints: const BoxConstraints(maxWidth: 400),
              // contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              border: kInputBorder,
              focusedBorder: kInputBorder,
              hintText: "Search sources",
              hintStyle: AppFonts.nunito.copyWith(
                fontSize: 16,
                color: AppColors.thisWhite.withOpacity(.5),
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 16,
                maxWidth: 48,
              ),
              suffixIcon: isLoading
                  ? Center(
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: AppColors.thisWhite,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 16,
                maxWidth: 48,
              ),
              prefixIcon: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 16,
                  maxWidth: 48,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/svg/search-two-tone.svg",
                    // ignore: deprecated_member_use
                    color: AppColors.thisWhite,
                    height: 16,
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../data/models/shen_image.dart';
import 'file_image/file_image.dart';
import 'network_image/networkImage.dart';

class MultiSourceImage extends StatelessWidget {
  const MultiSourceImage({
    Key? key,
    required this.source,
    required this.url,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    this.loadingIndicator,
    required this.radius,
    this.fit,
    this.referer,
    this.useOriginalSize = false,
    this.onLoadComplete,
    this.shouldRetry = false,
    this.useOldImageOnUrlChange = false,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Widget? loadingIndicator;
  final VoidCallback? onLoadComplete;
  final double radius;
  final String? referer;
  final bool shouldRetry;
  final ImageSource source;
  final String url;
  final bool useOldImageOnUrlChange;
  final bool useOriginalSize;

  @override
  Widget build(BuildContext context) => source == ImageSource.file
      ? ShenFileImage(
          radius: radius,
          shouldRetry: shouldRetry,
          source: source,
          url: url,
          useOriginalSize: useOriginalSize,
          accent: accent,
          backgroundColor: backgroundColor,
          errorPlaceholder: errorPlaceholder,
          fit: fit,
          loadingIndicator: loadingIndicator,
        )
      : ShenNetworkImage(
          radius: radius,
          shouldRetry: shouldRetry,
          source: source,
          url: url,
          useOriginalSize: useOriginalSize,
          useOldImageOnUrlChange: useOldImageOnUrlChange,
          accent: accent,
          backgroundColor: backgroundColor,
          errorPlaceholder: errorPlaceholder,
          fit: fit,
          loadingIndicator: loadingIndicator,
          referer: referer,
          onLoadComplete: onLoadComplete,
        );
}

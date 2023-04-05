import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../data/models/shen_image.dart';
import 'error_widget.dart';
import 'progress_indicator.dart';

final _log = Logger('multi_source_network_image');

class ShenNetworkImage extends StatefulWidget {
  const ShenNetworkImage({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    this.fit,
    this.loadingIndicator,
    required this.radius,
    required this.shouldRetry,
    required this.source,
    required this.url,
    required this.useOriginalSize,
    this.referer,
    this.useOldImageOnUrlChange = false,
    this.onLoadComplete,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Widget? loadingIndicator;
  final double radius;
  final String? referer;
  final bool shouldRetry;
  final ImageSource source;
  final String url;
  final bool useOriginalSize;
  final VoidCallback? onLoadComplete;
  final bool useOldImageOnUrlChange;

  @override
  State<ShenNetworkImage> createState() => _ShenNetworkImageState();
}

class _ShenNetworkImageState extends State<ShenNetworkImage> {
  late CachedNetworkImage image;

  void loadImage() {
    // _log.info('Loading Network image: ${widget.url}');
    image = CachedNetworkImage(
      imageUrl: widget.url,
      fit: widget.fit ?? BoxFit.contain,
      height: widget.useOriginalSize ? null : widget.radius * 2,
      width: widget.useOriginalSize ? null : widget.radius * 2,
      httpHeaders: {
        if (widget.referer != null) 'referer': widget.referer!,
      },
      useOldImageOnUrlChange: widget.useOldImageOnUrlChange,
      errorWidget: (context, url, error) => NetworkImageErrorWidget(
        url: url,
        radius: widget.radius,
        shouldRetry: widget.shouldRetry,
        source: widget.source,
        accent: widget.accent,
        backgroundColor: widget.backgroundColor,
        error: error,
        errorPlaceholder: widget.errorPlaceholder,
        onRetry: () {
          if (!mounted) return;
          setState(loadImage);
        },
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          NetworkImageProgressIndicator(
        radius: widget.radius,
        accent: widget.accent,
        backgroundColor: widget.backgroundColor,
        downloadProgress: downloadProgress,
        loadingIndicator: widget.loadingIndicator,
      ),
      imageBuilder: (context, imageProvider) {
        widget.onLoadComplete?.call();
        return Image(
          image: imageProvider,
          fit: widget.fit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loadImage();
    return image;
  }
}

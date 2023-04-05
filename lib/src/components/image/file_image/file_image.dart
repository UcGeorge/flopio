import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../data/models/shen_image.dart';
import 'error_builder.dart';
import 'loading_builder.dart';

class ShenFileImage extends StatefulWidget {
  const ShenFileImage({
    Key? key,
    this.accent,
    this.backgroundColor,
    this.errorPlaceholder,
    this.fit,
    required this.radius,
    required this.shouldRetry,
    this.loadingIndicator,
    required this.source,
    required this.url,
    required this.useOriginalSize,
  }) : super(key: key);

  final Color? accent;
  final Color? backgroundColor;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Widget? loadingIndicator;
  final double radius;
  final bool shouldRetry;
  final ImageSource source;
  final String url;
  final bool useOriginalSize;

  @override
  State<ShenFileImage> createState() => _ShenFileImageState();
}

class _ShenFileImageState extends State<ShenFileImage> {
  late Image image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() {
    image = Image.file(
      File(widget.url),
      height: widget.useOriginalSize ? null : widget.radius * 2,
      width: widget.useOriginalSize ? null : widget.radius * 2,
      fit: widget.fit ?? BoxFit.contain,
      alignment: Alignment.center,
      errorBuilder: (context, obj, stackTrace) => FileImageErrorBuilder(
        radius: widget.radius,
        shouldRetry: widget.shouldRetry,
        source: widget.source,
        errorObj: obj,
        accent: widget.accent,
        backgroundColor: widget.backgroundColor,
        errorPlaceholder: widget.errorPlaceholder,
        stackTrace: stackTrace,
        onRetry: () {
          if (!mounted) return;
          setState(loadImage);
        },
      ),
      frameBuilder: (context, widget_, progress, bol) =>
          FileImageLoadingBuilder(
        radius: widget.radius,
        widget: widget_,
        accent: widget.accent,
        backgroundColor: widget.backgroundColor,
        loadingIndicator: widget.loadingIndicator,
        progress: progress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => image;
}

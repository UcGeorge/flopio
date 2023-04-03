import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'log.util.dart';
import 'screen.util.dart';

class LocalFileUtil {
  static Future<String> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    return result?.files.single.path ?? "";
  }

  static Future<String> getImage(BuildContext context) async {
    ImageSource? source;

    if (Platform.isIOS) {
      source = await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text('Gallery'),
            ),
            SizedBox(
              height: ScreenUtil.screenViewPadding(context).bottom,
            ),
          ],
        ),
      );
    } else {
      source = await showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
              title: const Text('Camera'),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              title: const Text('Gallery'),
            ),
            SizedBox(
              height: ScreenUtil.screenViewPadding(context).bottom,
            ),
          ],
        ),
      );
    }

    if (source == null) return "";

    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return "";
      return image.path;
    } on PlatformException catch (e) {
      LogUtil.logError("LocalImageUtil", message: 'failed to pick image $e');
      return "";
    }
  }
}

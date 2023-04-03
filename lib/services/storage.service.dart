import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../app/app.dart';
import '../data/models/app_data.dart';
import '../state/app.state.dart';
import '../util/log.util.dart';

class StorageService {
  static void init({Function(String)? onError}) async {
    LogUtil.devLog("StorageService.init()", message: 'Initializing storage');
    Directory appDocDir = await getApplicationDocumentsDirectory();

    final directory = Directory(AppInfo.appDir(appDocDir.path));
    try {
      //* Create App directory if it does not exist
      if (!await directory.exists()) {
        LogUtil.devLog(
          "StorageService.init()",
          message: 'Creating app directory',
        );
        await directory.create(recursive: true);
      }

      final dataFile = File(AppInfo.dataFileDir(appDocDir.path));
      if (!await dataFile.exists()) {
        LogUtil.devLog(
          "StorageService.init()",
          message: 'Creating app data file',
        );
        await dataFile.create(recursive: true);
        await dataFile.writeAsString(
          AppData.empty().toJson(),
          mode: FileMode.write,
        );
      } else {
        LogUtil.devLog(
          "StorageService.init()",
          message: 'Reading from app data file',
        );
        String contents = await dataFile.readAsString();
        final stateData = AppData.fromJson(contents);
        AppState.state.update(stateData);
      }
    } on Exception catch (ex) {
      LogUtil.devLog("StorageService.init()", message: ex.toString());
      onError?.call(ex.toString());
    }
  }

  static Future<void> saveData(AppData data) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    LogUtil.devLog(
      "StorageService.saveData()",
      message: 'Writing to app data file',
    );
    final dataFile = File(AppInfo.dataFileDir(appDocDir.path));
    await dataFile.writeAsString(
      data.toJson(),
      mode: FileMode.write,
    );
  }
}

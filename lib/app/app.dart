import 'package:flopio/data/sources/ddl.dart';

import '../data/sources/manganelo.dart';
import '../data/sources/wuxia_world.dart';
import 'source.dart';

class AppInfo {
  static List<BookSource> appBookSources = [
    const Manganelo(),
    const WuxiaWorld(),
    const DivineDaoLibrary()
  ];
  static String appVer = '1.0.0';

// String appDir(String appDocDir) => '$appDocDir\\Shen-Ku';
  static String appDir(String appDocDir) => 'Shen-Ku';

  static String dataFileDir(String appDocDir) =>
      '${appDir(appDocDir)}\\app-data.json';
}

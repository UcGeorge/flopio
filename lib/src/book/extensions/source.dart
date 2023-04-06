import '../../../app/source.dart';

extension BookSourceQuery on List<BookSource> {
  BookSource getSource(String source) => firstWhere(
      (element) => element.name.toLowerCase() == source.toLowerCase());
}

import '../app/streamed_value.dart';
import '../data/models/book.dart';

class UpdateState {
  static StreamedValue<Map<Book, DateTime>> updateLog =
      StreamedValue<Map<Book, DateTime>>(initialValue: {});
}

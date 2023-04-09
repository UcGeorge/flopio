import '../../app/source.dart';
import '../models/book.dart';
import '../models/chapter.dart';

class WuxiaWorld extends BookSource {
  const WuxiaWorld() : super('Wuxia World');

  @override
  String get domain => "https://www.wuxiaworld.com/";

  @override
  Future<Chapter> getBookChapterDetails(Chapter chapter) async {
    // TODO: implement getBookChapterDetails
    throw UnimplementedError();
  }

  @override
  Future<Book> getBookDetails(Book book, {required List<String> fields}) async {
    // TODO: implement getBookDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getHomePage() async {
    await Future.delayed(const Duration(seconds: 5));
    return [];
  }

  @override
  Future<List<Book>> search(String term) async {
    // TODO: implement search
    throw UnimplementedError();
  }
}

import 'package:web_scraper/web_scraper.dart';

import '../../app/source.dart';
import '../../util/log.util.dart';
import '../../util/string.util.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../models/shen_image.dart';

class Manganelo extends BookSource {
  const Manganelo() : super('Manganelo');

  @override
  String get domain => "https://manganato.com";

  @override
  Future<Chapter> getBookChapterDetails(Chapter chapter) async {
    const chapterImageSelector = '.container-chapter-reader img';

    final webScraper = WebScraper(domain);

    Chapter result = chapter.copyWith(chapterImages: []);

    try {
      if (await webScraper.loadFullURL(chapter.link)) {
        //* Get chapter pictures
        webScraper.getElement(chapterImageSelector, ['src']).iterate((e, i) {
          var src = e['attributes']['src'];
          result.chapterImages!.add(ShenImage(src));
        });

        return result;
      } else {
        throw Exception('Unable to get chapter details');
      }
    } on WebScraperException catch (e) {
      LogUtil.devLog(name, message: e.errorMessage() ?? "");
      return result;
    }
  }

  @override
  Future<Book> getBookDetails(Book book, {required List<String> fields}) async {
    const coverImageSelector = '.info-image';
    const rateSelector = '#rate_row_cmd em[property="v:average"]';
    const statusTableValueSelector = '.variations-tableInfo td.table-value';
    const descriptionSelector = '#panel-story-info-description';
    const chapterNameSelector = '.row-content-chapter .a-h a';

    LogUtil.devLog(
      name,
      message: 'Getting details from ${book.link}',
    );
    final webScraper = WebScraper(domain);

    Book result = book;

    try {
      if (await webScraper.loadFullURL(book.link)) {
        //* Get cover picture
        if (fields.contains('coverPicture')) {
          webScraper.getElement(coverImageSelector, ['src']).iterate((e, i) {
            var src = e['attributes']['src'];
            result = result.copyWith(coverPicture: ShenImage(src));
          });
        }

        //* Get rating
        if (fields.contains('rating')) {
          webScraper.getElement(rateSelector, []).iterate((e, i) {
            var rating = e['title'];
            result = result.copyWith(rating: rating);
          });
        }

        //* Get status
        if (fields.contains('status')) {
          webScraper
              .getElement(statusTableValueSelector, [])
              .where(
                  (e) => e['title'] == 'Ongoing' || e['title'] == 'Completed')
              .toList()
              .iterate((e, i) {
                var status = e['title'] == 'Ongoing'
                    ? BookStatus.ongoing
                    : BookStatus.completed;
                result = result.copyWith(status: status);
              });
        }

        //* Get status
        if (fields.contains('description')) {
          webScraper.getElement(descriptionSelector, []).iterate((e, i) {
            var description = e['title']
                .toString()
                .replaceAll('Description :', '')
                .replaceAll('"', '')
                .trim();
            result = result.copyWith(description: description);
          });
        }

        //* Get chapters & chapterCount
        List<Chapter> chapters = [];
        webScraper.getElement(chapterNameSelector, ['href']).iterate((e, i) {
          var name = e['title'];
          var link = e['attributes']['href'];
          chapters.add(Chapter(
            id: (domain + book.name + name).toHash,
            name: name,
            link: link,
            source: ChapterSource.network,
          ));
        });
        result = result.copyWith(
          chapters: chapters,
          chapterCount: chapters.length,
        );

        return result;
      } else {
        throw Exception('Unable to get book details');
      }
    } on WebScraperException catch (e) {
      LogUtil.devLog(name, message: e.errorMessage() ?? "");
      return result;
    }
  }

  @override
  Future<List<Book>> getHomePage() async {
    const String homePageEndpoint = "/genre-all?type=topview";
    const String homePageItemCoverImage = ".content-genres-item a img";
    const String homePageItemTitle = ".content-genres-item h3 a";

    List<Book> result = [];
    LogUtil.devLog(name, message: 'Getting homepage');
    final webScraper = WebScraper(domain);

    try {
      if (await webScraper.loadWebPage(homePageEndpoint)) {
        webScraper.getElement(homePageItemTitle, ['href']).forEach((e) {
          var title = e['title'];
          var href = e['attributes']['href'];
          result.add(Book(
            id: (domain + title).toHash,
            name: title,
            type: BookType.manga,
            link: href,
            source: name,
          ));
        });

        //* Get cover picture
        webScraper.getElement(homePageItemCoverImage, ['src']).iterate((e, i) {
          var src = e['attributes']['src'];
          result[i] = result[i].copyWith(coverPicture: ShenImage(src));
        });

        return result;
      } else {
        throw Exception('Unable to get homepage');
      }
    } on WebScraperException catch (e) {
      LogUtil.devLog(name, message: e.errorMessage() ?? "");
      return result;
    }
  }

  @override
  Future<List<Book>> search(String term) async {
    final String searchPageEndpoint = "/search/story/${term.toSnakeCase()}";
    const String searchPageItemTitle = ".search-story-item h3 a";
    const String homePageItemCoverImage = ".search-story-item a img";

    List<Book> result = [];
    LogUtil.devLog(name, message: 'Searching $term');
    final webScraper = WebScraper(domain);

    try {
      if (await webScraper.loadWebPage(searchPageEndpoint)) {
        webScraper.getElement(searchPageItemTitle, ['href']).forEach((e) {
          var title = e['title'];
          var href = e['attributes']['href'];
          result.add(Book(
            id: (domain + title).toHash,
            name: title,
            type: BookType.manga,
            link: href,
            source: name,
          ));
        });

        //* Get cover picture
        webScraper.getElement(homePageItemCoverImage, ['src']).iterate((e, i) {
          var src = e['attributes']['src'];
          result[i] = result[i].copyWith(coverPicture: ShenImage(src));
        });

        LogUtil.devLog(name, message: 'Found ${result.length} results');
        return result;
      } else {
        throw Exception('Unable to get search results');
      }
    } on WebScraperException catch (e) {
      LogUtil.devLog(name, message: e.errorMessage() ?? "");
      return result;
    }
  }
}

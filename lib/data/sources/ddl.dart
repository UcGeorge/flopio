import 'package:web_scraper/web_scraper.dart';

import '../../app/source.dart';
import '../../util/log.util.dart';
import '../../util/string.util.dart';
import '../models/book.dart';
import '../models/chapter.dart';

class DivineDaoLibrary extends BookSource {
  const DivineDaoLibrary() : super('Divine Dao Lobrary');

  @override
  String get domain => "https://www.divinedaolibrary.com/";

  @override
  Future<Chapter> getBookChapterDetails(Chapter chapter) async {
    const chapterImageSelector = 'p > span';

    final webScraper = WebScraper(domain);

    Chapter result = chapter.copyWith(chapterParagraphs: []);

    try {
      if (await webScraper.loadFullURL(chapter.link)) {
        //* Get chapter pictures
        webScraper.getElement(chapterImageSelector, []).iterate((e, i) {
          var src = e['title'] as String;
          result.chapterParagraphs!.add(src.trim());
        });

        if (result.chapterParagraphs!.isEmpty) {
          result.chapterParagraphs!
            ..add("Oops! That page can't be found.")
            ..add(
                "The chapters are preloaded. Links being coloured does not mean chapters are up yet. They are just scheduled.");
        }

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
    const coverImageSelector = 'p > img';
    // const rateSelector = '#rate_row_cmd em[property="v:average"]';
    // const statusTableValueSelector = '.variations-tableInfo td.table-value';
    const descriptionSelector = 'h3 + p';
    const chapterNameSelector = 'li > span > a';

    LogUtil.devLog(
      name,
      message: 'Getting details from ${book.link}',
    );

    final webScraper = WebScraper(domain);

    Book result = book;

    try {
      if (await webScraper.loadFullURL(book.link)) {
        // //* Get cover picture
        // if (fields.contains('coverPicture')) {
        //   webScraper.getElement(coverImageSelector, ['src']).iterate((e, i) {
        //     var src = e['attributes']['src'];
        //     result = result.copyWith(coverPicture: ShenImage(src));
        //   });
        // }

        // //* Get rating
        // if (fields.contains('rating')) {
        //   webScraper.getElement(rateSelector, []).iterate((e, i) {
        //     var rating = e['title'];
        //     result = result.copyWith(rating: rating);
        //   });
        // }

        // //* Get status
        // if (fields.contains('status')) {
        //   webScraper
        //       .getElement(statusTableValueSelector, [])
        //       .where(
        //           (e) => e['title'] == 'Ongoing' || e['title'] == 'Completed')
        //       .toList()
        //       .iterate((e, i) {
        //         var status = e['title'] == 'Ongoing'
        //             ? BookStatus.ongoing
        //             : BookStatus.completed;
        //         result = result.copyWith(status: status);
        //       });
        // }

        //* Get description
        if (fields.contains('description')) {
          webScraper.getElement(descriptionSelector, []).iterate((e, i) {
            if (i > 0) return;
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
          chapters: chapters.reversed.toList(),
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
    const String homePageEndpoint = "/novels";
    const String homePageItemTitle = "ul > li > span > a";

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
            type: BookType.novel,
            link: href,
            source: name,
          ));
        });

        //* Get cover picture
        // webScraper.getElement(homePageItemCoverImage, ['src']).iterate((e, i) {
        //   var src = e['attributes']['src'];
        //   result[i] = result[i].copyWith(coverPicture: ShenImage(src));
        // });

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
  Future<List<Book>> search(String term) async => getHomePage();
}

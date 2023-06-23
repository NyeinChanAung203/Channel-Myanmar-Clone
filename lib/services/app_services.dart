import 'dart:convert';
import 'dart:developer';

import 'package:cm_movie/models/link.dart';
import 'package:cm_movie/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class AppService {
  static Future<List<Movie>> fetchMovies(int pageNo) async {
    final url = Uri.parse('https://channelmyanmar.org/movies/page/$pageNo/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('.item > div.fixyear > h2')
        .map((e) => e.text.trim())
        .toList();

    final urls = html
        .querySelectorAll('.item > a')
        .map((e) => e.attributes['href'])
        .toList();

    final imgUrls = html
        .querySelectorAll('.item > a > div > img')
        .map((e) => e.attributes['src'])
        .toList();

    final imdbs = html
        .querySelectorAll('.item > a > div > span.imdb')
        .map((e) => e.text.trim())
        .toList();

    final movies = List.generate(
        titles.length,
        (index) => Movie(
              title: titles[index],
              imgUrl: imgUrls[index] ?? 'invalid url',
              url: urls[index] ?? 'Invalid Url',
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return movies;
  }

  static Future<List<Movie>> fetchSeries(int pageNo) async {
    final url = Uri.parse('https://channelmyanmar.org/tvshows/page/$pageNo/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('.item > div.fixyear > h2')
        .map((e) => e.innerHtml.trim())
        .toList();

    final urls = html
        .querySelectorAll('.item > a')
        .map((e) => e.attributes['href'])
        .toList();

    final imgUrls = html
        .querySelectorAll('.item > a > div > img')
        .map((e) => e.attributes['src'])
        .toList();

    final imdbs = html
        .querySelectorAll('.item > a > div > span.imdb')
        .map((e) => e.text.trim())
        .toList();

    final movies = List.generate(
        titles.length,
        (index) => Movie(
              title: titles[index],
              imgUrl: imgUrls[index] ?? 'invalid url',
              url: urls[index] ?? 'Invalid Url',
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return movies;
  }

  static Future<List<Movie>> fetchSearchMovies(int? pageNo, String name) async {
    final url = Uri.parse('https://channelmyanmar.org/page/$pageNo/?s=$name');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('.item > div.fixyear > h2')
        .map((e) => e.text.trim())
        .toList();

    final urls = html
        .querySelectorAll('.item > a')
        .map((e) => e.attributes['href'])
        .toList();

    final imgUrls = html
        .querySelectorAll('.item > a > div > img')
        .map((e) => e.attributes['src'])
        .toList();

    final imdbs = html
        .querySelectorAll('.item > a > div > span.imdb')
        .map((e) => e.text.trim())
        .toList();

    final movies = List.generate(
        titles.length,
        (index) => Movie(
              title: titles[index],
              imgUrl: imgUrls[index] ?? 'invalid url',
              url: urls[index] ?? 'Invalid Url',
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return movies;
  }

  static Future<List<Movie>> fetchLatestMovies() async {
    final url = Uri.parse('https://channelmyanmar.org/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('.owl-item > span.ttps')
        .map((e) => e.text.trim())
        .toList();

    final urls = html
        .querySelectorAll('.owl-item > a')
        .map((e) => e.attributes['href'])
        .toList();

    final imgUrls = html
        .querySelectorAll('.owl-item > a > img')
        .map((e) => e.attributes['src'])
        .toList();

    final imdbs = html
        .querySelectorAll(
            '#slider2 > div > div > div.owl-item > div > div > span.imdb')
        .map((e) => e.text.trim())
        .toList();
    log('zzz ${titles.length} ${imgUrls.length} ${imdbs.length}');
    log('zzz');
    final movies = List.generate(
        titles.length,
        (index) => Movie(
              title: titles[index],
              imgUrl: imgUrls[index] ?? 'invalid url',
              url: urls[index] ?? 'Invalid Url',
              rating: '',
              // (imdbs.length == titles.length) ? imdbs[index] :
            ));

    return movies;
  }

  static Future<Movie> fetchMovieDetail(Movie movie) async {
    final uri = Uri.parse(movie.url);
    final response = await http.get(uri);
    dom.Document html = dom.Document.html(utf8.decode(response.body.codeUnits));

    final descriptions =
        html.querySelectorAll('#cap1 > p').map((e) => e.text.trim()).toList();

    // log(descriptions.toString());

    final linkNames = html
        .querySelectorAll(
            '#single > div.s_left > div > div > ul > li > a > span.b')
        .map((e) => e.text.trim())
        .toList();

    // log(linkNames.toString());

    final qualities = html
        .querySelectorAll(
            '#single > div.s_left > div > div > ul > li > a > span.d')
        .map((e) => e.text.trim())
        .toList();

    // log(qualities.toString());

    final fileSizes = html
        .querySelectorAll(
            '#single > div.s_left > div > div > ul > li > a > span.c')
        .map((e) => e.text.trim())
        .toList();

    // log(fileSizes.toString());

    final links = html
        .querySelectorAll('#single > div.s_left > div > div > ul > li > a')
        .map((e) => e.attributes['href'])
        .toList();

    // log(links.toString());

    final imgUrls =
        html.querySelector('#uwee > div.imagen > div > img')?.attributes['src'];

    log('imgurl $imgUrls');

    log('${linkNames.length} ${qualities.length} ${fileSizes.length} ${links.length}');
    final linkModelList = List.generate(
        linkNames.length,
        (index) => LinkModel(
            name: linkNames[index],
            url: links[index] ?? 'https://channelmyanmar.org',
            quality: qualities[index],
            fileSize: fileSizes[index]));

    final detailMovie = Movie(
        title: movie.title,
        imgUrl: imgUrls ?? '',
        url: movie.url,
        descriptions: descriptions,
        links: linkModelList,
        rating: '');

    return detailMovie;
  }

  static Future<Movie> fetchSeriesDetail(Movie movie) async {
    final uri = Uri.parse(movie.url);
    final response = await http.get(uri);
    dom.Document html = dom.Document.html(utf8.decode(response.body.codeUnits));

    final descriptions = html
        .querySelectorAll('#info > div.contenidotv > div')
        .map((e) => e.text.trim())
        .toList();

    // log(descriptions.toString());

    // final linkDatas = html
    //     .querySelectorAll('#info > div.contenidotv > div a')
    //     .map((e) => {
    //           'name': e.text.trim(),
    //           'link': e.attributes['href'],
    //         })
    //     .toList();

    // log(linkDatas.toString());

    // final episodeNames = html
    //     .querySelectorAll('#info > div.contenidotv > div a')
    //     .map((e) =>
    //         '${e.parentNode?.text.toString().split(' ').first} ${e.parentNode?.text.toString().split(' ')[1]}')
    //     .toList();
    // log('==============');
    // log(episodeNames.toString());
    // log('==============');

    ///
    // final qualities = html
    //     .querySelectorAll(
    //         '#single > div.s_left > div > div > ul > li > a > span.d')
    //     .map((e) => e.text.trim())
    //     .toList();

    // log(qualities.toString());

    // final fileSizes = html
    //     .querySelectorAll(
    //         '#single > div.s_left > div > div > ul > li > a > span.c')
    //     .map((e) => e.text.trim())
    //     .toList();

    // log(fileSizes.toString());

    // final links = html
    //     .querySelectorAll('#single > div.s_left > div > div > ul > li > a')
    //     .map((e) => e.attributes['href'])
    //     .toList();

    // log(links.toString());

    final imgUrl =
        html.querySelector('#fixar > div.imagen > img')?.attributes['src'];

    // log('imgurl $imgUrls');

    // log('${linkDatas.length} ${qualities.length} ${fileSizes.length} ${links.length}');
    // final linkModelList = List.generate(
    //     linkDatas.length,
    //     (index) => LinkModel(
    //         name: '',
    //         url: links[index] ?? 'https://channelmyanmar.org',
    //         quality: qualities[index],
    //         fileSize: fileSizes[index]));

    final detailMovie = Movie(
        title: movie.title,
        imgUrl: imgUrl ?? '',
        url: movie.url,
        descriptions: descriptions,
        links: [],
        rating: '');

    return detailMovie;
  }
}

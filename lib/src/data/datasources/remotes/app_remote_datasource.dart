import 'dart:convert';
import 'dart:developer';

import 'package:cm_movie/src/config/constants/strings.dart';
import 'package:cm_movie/src/data/models/genre_dto.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../../models/link_dto.dart';
import '../../models/movie_dto.dart';

class AppRemoteDataSource {
  const AppRemoteDataSource();

  Future<List<MovieDTO>> fetchMoviesByGenre(String name, int pageNo) async {
    final url = Uri.parse(
        'https://channelmyanmar.org/category/${name.toLowerCase()}/page/$pageNo/');
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

    final moviesDto = List.generate(
        titles.length,
        (index) => MovieDTO(
              title: titles[index],
              imgUrl: imgUrls[index] ?? kImgUrl,
              url: urls[index] ?? kUrl,
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return moviesDto;
  }

  Future<List<GenreDTO>> fetchGenres() async {
    final url = Uri.parse('https://channelmyanmar.org/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final genres = html
        .querySelectorAll('#moviehome > div.categorias > ul > li')
        .map((e) => e.text.trim())
        .toList();

    log(genres.toString());

    final genreLinks = html
        .querySelectorAll('#moviehome > div.categorias > ul > li > a')
        .map((e) => e.attributes['href'])
        .toList();

    log(genreLinks.toString());
    log("${genres.length} , ${genreLinks.length}");

    final genresList = List.generate(
        genres.length,
        (index) => GenreDTO(
            name: genres[index].split(' ').first,
            url: genreLinks[index] ?? kUrl,
            total: genres[index].split(' ').last));

    return genresList;
  }

  Future<List<MovieDTO>> fetchMovies(int pageNo) async {
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
        (index) => MovieDTO(
              title: titles[index],
              imgUrl: imgUrls[index] ?? kImgUrl,
              url: urls[index] ?? kUrl,
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return movies;
  }

  Future<List<MovieDTO>> fetchSeries(int pageNo) async {
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
        (index) => MovieDTO(
              title: titles[index],
              imgUrl: imgUrls[index] ?? kImgUrl,
              url: urls[index] ?? kUrl,
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    return movies;
  }

  Future<List<MovieDTO>> fetchSearchMovies(int? pageNo, String name) async {
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
        (index) => MovieDTO(
              title: titles[index],
              imgUrl: imgUrls[index] ?? kImgUrl,
              url: urls[index] ?? kUrl,
              rating: (imdbs.length == titles.length) ? imdbs[index] : '',
            ));

    log(movies.toString());
    return movies;
  }

  Future<MovieDTO> fetchDetail(MovieDTO movie) async {
    final uri = Uri.parse(movie.url);
    final response = await http.get(uri);
    dom.Document html = dom.Document.html(utf8.decode(response.body.codeUnits));
    if (movie.url.contains('tvshows')) {
      //********** Tv Shows *****************/
      final descriptions = html
          .querySelectorAll('#info > div.contenidotv > div')
          .map((e) => e.text.toString())
          .toList();

      log('$descriptions');

      // final linkDatas = html
      //     .querySelectorAll('#info > div.contenidotv > div a')
      //     .map((e) => {
      //           'name': e.text.trim(),
      //           'link': e.attributes['href'],
      //         })
      //     .toList();

      // log(linkDatas.toString());

      final imgUrl =
          html.querySelector('#fixar > div.imagen > img')?.attributes['src'];

      final detailMovie = MovieDTO(
          title: movie.title,
          imgUrl: imgUrl ?? '',
          url: movie.url,
          descriptions: descriptions,
          links: [],
          rating: '');

      return detailMovie;
    } else {
      // ************************ movie ***************************************

      final descriptions =
          html.querySelectorAll('#cap1  p').map((e) => e.text.trim()).toList();

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

      final imgUrls = html
          .querySelector('#uwee > div.imagen > div > img')
          ?.attributes['src'];

      log('imgurl $imgUrls');

      log('${linkNames.length} ${qualities.length} ${fileSizes.length} ${links.length}');
      final linkModelList = List.generate(
          linkNames.length,
          (index) => LinkDTO(
              name: linkNames[index],
              url: links[index] ?? 'https://channelmyanmar.org',
              quality: qualities[index],
              fileSize: fileSizes[index]));

      final detailMovie = MovieDTO(
          title: movie.title,
          imgUrl: imgUrls ?? kImgUrl,
          url: movie.url,
          descriptions: descriptions,
          links: linkModelList,
          rating: '');

      log(detailMovie.toString());
      return detailMovie;
    }
  }
}

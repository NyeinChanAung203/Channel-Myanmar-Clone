import 'dart:developer';

import 'package:cm_movie/models/genre.dart';
import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/services/app_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';

class GenreProvider extends ChangeNotifier {
  bool loading = false;
  int pageNo = 1;
  String genreValue = '';

  setLoading() {
    loading = true;
    notifyListeners();
  }

  removeLoading() {
    loading = false;
    notifyListeners();
  }

  List<Movie> movies = [];

  Future<void> nextPage() async {
    pageNo++;
    await fetchMovieByGenre();
  }

  Future<void> backPage() async {
    if (pageNo > 1) {
      pageNo--;
      await fetchMovieByGenre();
    }
  }

  Future<void> fetchMovieByGenre({int? pageNumber}) async {
    try {
      setLoading();
      if (pageNumber != null) {
        pageNo = pageNumber;
      }
      await AppService.fetchMoviesByGenre(genreValue, pageNo).then((movieList) {
        movies = movieList;
        log('movies => $movies');
        removeLoading();
      });
    } catch (e) {
      toast(e.toString());
      log('fetchMovieByGenre error $e');
      removeLoading();
    }
  }

  List<Genre> genres = [];

  Future<void> fetchGenres() async {
    try {
      setLoading();
      await AppService.fetchGenres().then((value) {
        genres = value;
        removeLoading();
      });
    } catch (e) {
      log('error $e');
      toast(e.toString());
      removeLoading();
    }
  }
}

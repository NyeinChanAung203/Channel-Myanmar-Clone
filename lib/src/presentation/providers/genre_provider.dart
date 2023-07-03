import 'dart:developer';

import 'package:cm_movie/src/domain/usecases/genre_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/movie.dart';

class GenreProvider extends ChangeNotifier {
  final GenreUseCaseImpl _genreUseCaseImpl;

  GenreProvider(this._genreUseCaseImpl);

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
    if (movies.isNotEmpty) {
      pageNo++;
      await fetchMovieByGenre();
    }
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
      await _genreUseCaseImpl
          .fetchByGenres(genreValue, pageNo)
          .then((movieList) {
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
      await _genreUseCaseImpl.fetchAllGenres().then((value) {
        genres = value;
        log(genres.length.toString());
        removeLoading();
      });
    } catch (e) {
      log('error $e');
      toast(e.toString());
      removeLoading();
    }
  }
}

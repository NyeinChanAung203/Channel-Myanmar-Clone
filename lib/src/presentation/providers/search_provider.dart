import 'dart:developer';

import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/usecases/movie_usecase.dart';
import 'package:cm_movie/src/domain/usecases/search_usecase.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class SearchProvider extends ChangeNotifier {
  final SearchUseCaseImpl _searchUseCaseImpl;
  final MovieUseCaseImpl _movieUseCaseImpl;

  SearchProvider(this._searchUseCaseImpl, this._movieUseCaseImpl);

  bool loading = false;
  int pageNo = 1;

  TextEditingController name = TextEditingController();

  setLoading() {
    loading = true;
    notifyListeners();
  }

  removeLoading() {
    loading = false;
    notifyListeners();
  }

  List<Movie> searchedMovies = [];

  Future<void> nextPage() async {
    if (searchedMovies.isNotEmpty) {
      pageNo++;
      await fetchSearchMovie();
    }
  }

  Future<void> backPage() async {
    if (pageNo > 1) {
      pageNo--;
      await fetchSearchMovie();
    }
  }

  void resetState() {
    pageNo = 1;
    name.clear();
    notifyListeners();
  }

  Future<void> fetchSearchMovie({int? pageNumber}) async {
    try {
      setLoading();
      if (pageNumber != null) {
        pageNo = pageNumber;
      }
      await _searchUseCaseImpl
          .fetchSearchMovies(pageNo, name.text.trim())
          .then((movieList) {
        searchedMovies = movieList;

        log(searchedMovies.toString());
        removeLoading();
      });
    } catch (e) {
      toast(e.toString());
      log('fetch movie error $e');
      removeLoading();
    }
  }

  Movie? movieDetail;
  Future<void> detailMovie(Movie movie) async {
    try {
      setLoading();
      await _movieUseCaseImpl.getDetail(movie).then((value) {
        movieDetail = value;
        removeLoading();
      });
    } catch (e) {
      log('error $e');
      toast(e.toString());
      removeLoading();
    }
  }
}

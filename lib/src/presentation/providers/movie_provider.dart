import 'dart:developer';

import 'package:cm_movie/src/domain/usecases/movie_usecase.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../domain/entities/movie.dart';

class MovieProvider extends ChangeNotifier {
  final MovieUseCaseImpl _movieUseCaseImpl;

  MovieProvider(this._movieUseCaseImpl);

  bool loading = false;
  int pageNo = 1;

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
    fetchMovie();
  }

  Future<void> backPage() async {
    if (pageNo > 1) {
      pageNo--;
      await fetchMovie();
    }
  }

  Future<void> fetchMovie({int? pageNumber}) async {
    try {
      setLoading();
      if (pageNumber != null) {
        pageNo = pageNumber;
      }
      await _movieUseCaseImpl.getAll(pageNo).then((movieList) {
        movies = movieList;

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

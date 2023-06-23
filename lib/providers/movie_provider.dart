import 'dart:developer';

import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class MovieProvider extends ChangeNotifier {
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
    await fetchMovie();
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
      await AppService.fetchMovies(pageNo).then((movieList) {
        movies = movieList;
        log(movies.toString());
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
      await AppService.fetchMovieDetail(movie).then((value) {
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

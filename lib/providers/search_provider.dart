import 'dart:developer';

import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class SearchProvider extends ChangeNotifier {
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
    pageNo++;
    await fetchSearchMovie();
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
      await AppService.fetchSearchMovies(pageNo, name.text.trim())
          .then((movieList) {
        searchedMovies = movieList;
        if (searchedMovies.isEmpty) {
          pageNo = 1;
        }
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

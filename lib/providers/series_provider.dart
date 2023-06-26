import 'dart:developer';

import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class SeriesProvider extends ChangeNotifier {
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

  Future<void> nextPage() async {
    pageNo++;
    await fetchSeries();
  }

  Future<void> backPage() async {
    if (pageNo > 1) {
      pageNo--;
      await fetchSeries();
    }
  }

  List<Movie> series = [];

  Future<void> fetchSeries({int? pageNumber}) async {
    try {
      setLoading();
      if (pageNumber != null) {
        pageNo = pageNumber;
      }
      await AppService.fetchSeries(pageNo).then((movieList) {
        series = movieList;
        removeLoading();
      });
    } catch (e) {
      toast(e.toString());
      log('fetch series error $e');
      removeLoading();
    }
  }

  Movie? seriesDetail;
  Future<void> detailSeries(Movie movie) async {
    try {
      setLoading();
      await AppService.fetchDetail(movie).then((value) {
        seriesDetail = value;
        removeLoading();
      });
    } catch (e) {
      log('error $e');
      toast(e.toString());
      removeLoading();
    }
  }
}

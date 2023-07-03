import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../models/movie_dto.dart';

class LocalDatabase {
  static Box<MovieDTO> getMovieBox() => Hive.box<MovieDTO>('moviesBox');

  void addMovie(MovieDTO movie) {
    Box box = getMovieBox();
    if (box.values
        .toList()
        .cast<MovieDTO>()
        .any((MovieDTO element) => element.url == movie.url)) {
      showSimpleNotification(const Text('Already Added to Favorites'),
          duration: const Duration(milliseconds: 600));
    } else {
      box.add(movie);
      showSimpleNotification(const Text('Successfully Added to Favorites'),
          duration: const Duration(milliseconds: 1000));
    }
  }
}

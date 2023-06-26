import 'package:cm_movie/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';

class Boxes {
  static Box<Movie> getMovieBox() => Hive.box<Movie>('moviesBox');

  static void addMovie(Movie movie) {
    Box box = getMovieBox();
    if (box.values
        .toList()
        .cast<Movie>()
        .any((Movie element) => element.title == movie.title)) {
      showSimpleNotification(const Text('Already Added to Favorites'),
          duration: const Duration(milliseconds: 600));
    } else {
      box.add(movie);
      showSimpleNotification(const Text('Successfully Added to Favorites'),
          duration: const Duration(milliseconds: 1000));
    }
  }
}

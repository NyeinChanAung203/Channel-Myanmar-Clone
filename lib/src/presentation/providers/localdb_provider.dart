import 'package:cm_movie/src/domain/usecases/localdb_usecase.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

class LocalDBProvider extends ChangeNotifier {
  final LocalDBUseCaseImpl _dbUseCaseImpl;

  LocalDBProvider(this._dbUseCaseImpl);

  addMovieToFavorite(Movie movie) {
    _dbUseCaseImpl.addMovie(movie);
  }
}

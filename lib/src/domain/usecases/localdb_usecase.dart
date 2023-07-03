import 'package:cm_movie/src/data/repositories/localdb_repository_impl.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class LocalDBUseCase {
  void addMovie(Movie movie);
}

class LocalDBUseCaseImpl extends LocalDBUseCase {
  final LocaldbRepositoryImpl _impl;

  LocalDBUseCaseImpl(this._impl);

  @override
  void addMovie(Movie movie) {
    _impl.addMovieToFavorite(movie);
  }
}

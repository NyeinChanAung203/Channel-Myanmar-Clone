import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/localdb_repository.dart';

abstract class LocalDBUseCase {
  void addMovie(Movie movie);
}

class LocalDBUseCaseImpl extends LocalDBUseCase {
  final LocalDBRepository _localDBRepository;

  LocalDBUseCaseImpl(this._localDBRepository);

  @override
  void addMovie(Movie movie) {
    _localDBRepository.addMovieToFavorite(movie);
  }
}

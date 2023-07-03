import 'package:cm_movie/src/data/repositories/movie_repository_impl.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class MovieUseCase {
  Future<List<Movie>> getAll(int pageNo);
  Future<Movie> getDetail(Movie movie);
}

class MovieUseCaseImpl extends MovieUseCase {
  MovieUseCaseImpl(this._movieRepositoryImpl);

  final MovieRepositoryImpl _movieRepositoryImpl;

  @override
  Future<List<Movie>> getAll(int pageNo) async {
    return await _movieRepositoryImpl.fetchMovies(pageNo);
  }

  @override
  Future<Movie> getDetail(Movie movie) async {
    return await _movieRepositoryImpl.fetchMovieDetail(movie);
  }
}

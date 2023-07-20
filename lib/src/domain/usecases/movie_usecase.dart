import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/movie_repository.dart';

abstract class MovieUseCase {
  Future<List<Movie>> getAll(int pageNo);
  Future<Movie> getDetail(Movie movie);
}

class MovieUseCaseImpl extends MovieUseCase {
  MovieUseCaseImpl(this._movieRepository);

  final MovieRepository _movieRepository;

  @override
  Future<List<Movie>> getAll(int pageNo) async {
    return await _movieRepository.fetchMovies(pageNo);
  }

  @override
  Future<Movie> getDetail(Movie movie) async {
    return await _movieRepository.fetchMovieDetail(movie);
  }
}

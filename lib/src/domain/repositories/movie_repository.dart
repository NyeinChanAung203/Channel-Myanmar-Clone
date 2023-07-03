import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(int pageNo);
  Future<Movie> fetchMovieDetail(Movie movie);
}

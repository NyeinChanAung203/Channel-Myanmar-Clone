import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class SearchRepository {
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name);
}

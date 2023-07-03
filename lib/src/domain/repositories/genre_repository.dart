import 'package:cm_movie/src/domain/entities/movie.dart';

import '../entities/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> fetchAllGenres();
  Future<List<Movie>> fetchByGenres(String name, int pageNo);
}

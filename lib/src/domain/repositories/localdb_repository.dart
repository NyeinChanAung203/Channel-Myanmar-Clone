import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class LocalDBRepository {
  void addMovieToFavorite(Movie movie);
}

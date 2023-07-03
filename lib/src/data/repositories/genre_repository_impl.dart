import 'package:cm_movie/src/data/datasources/remotes/app_remote_datasource.dart';
import 'package:cm_movie/src/data/models/genre_dto.dart';
import 'package:cm_movie/src/data/models/movie_dto.dart';
import 'package:cm_movie/src/domain/entities/genre.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/genre_repository.dart';

class GenreRepositoryImpl implements GenreRepository {
  final AppRemoteDataSource _appRemoteDataSource;
  const GenreRepositoryImpl(this._appRemoteDataSource);

  @override
  Future<List<Genre>> fetchAllGenres() async {
    try {
      final List<GenreDTO> genres = await _appRemoteDataSource.fetchGenres();
      return genres.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<List<Movie>> fetchByGenres(String name, int pageNo) async {
    try {
      final List<MovieDTO> movies =
          await _appRemoteDataSource.fetchMoviesByGenre(name, pageNo);
      return movies.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

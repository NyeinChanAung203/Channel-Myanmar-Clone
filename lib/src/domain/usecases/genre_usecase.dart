import 'package:cm_movie/src/data/repositories/genre_repository_impl.dart';
import 'package:cm_movie/src/domain/entities/genre.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class GenreUseCase {
  Future<List<Genre>> fetchAllGenres();
  Future<List<Movie>> fetchByGenres(String name, int pageNo);
}

class GenreUseCaseImpl extends GenreUseCase {
  final GenreRepositoryImpl _genreRepositoryImpl;

  GenreUseCaseImpl(this._genreRepositoryImpl);

  @override
  Future<List<Genre>> fetchAllGenres() async {
    return await _genreRepositoryImpl.fetchAllGenres();
  }

  @override
  Future<List<Movie>> fetchByGenres(String name, int pageNo) async {
    return await _genreRepositoryImpl.fetchByGenres(name, pageNo);
  }
}

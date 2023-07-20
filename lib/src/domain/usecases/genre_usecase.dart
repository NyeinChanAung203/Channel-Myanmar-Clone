import 'package:cm_movie/src/domain/entities/genre.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

import '../repositories/genre_repository.dart';

abstract class GenreUseCase {
  Future<List<Genre>> fetchAllGenres();
  Future<List<Movie>> fetchByGenres(String name, int pageNo);
}

class GenreUseCaseImpl extends GenreUseCase {
  final GenreRepository _genreRepository;

  GenreUseCaseImpl(this._genreRepository);

  @override
  Future<List<Genre>> fetchAllGenres() async {
    return await _genreRepository.fetchAllGenres();
  }

  @override
  Future<List<Movie>> fetchByGenres(String name, int pageNo) async {
    return await _genreRepository.fetchByGenres(name, pageNo);
  }
}

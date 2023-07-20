import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/search_repository.dart';

abstract class SearchUseCase {
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name);
}

class SearchUseCaseImpl extends SearchUseCase {
  final SearchRepository _searchRepository;

  SearchUseCaseImpl(this._searchRepository);

  @override
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name) async {
    final movies = await _searchRepository.fetchSearchMovies(pageNo, name);
    return movies;
  }
}

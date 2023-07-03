import 'package:cm_movie/src/data/repositories/search_repository_impl.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class SearchUseCase {
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name);
}

class SearchUseCaseImpl extends SearchUseCase {
  final SearchRepositoryImpl _searchRepositoryImpl;

  SearchUseCaseImpl(this._searchRepositoryImpl);

  @override
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name) async {
    final movies = await _searchRepositoryImpl.fetchSearchMovies(pageNo, name);
    return movies;
  }
}

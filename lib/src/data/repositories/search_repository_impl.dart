import 'package:cm_movie/src/data/datasources/remotes/app_remote_datasource.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final AppRemoteDataSource _appRemoteDataSource;

  const SearchRepositoryImpl(this._appRemoteDataSource);

  @override
  Future<List<Movie>> fetchSearchMovies(int pageNo, String name) async {
    try {
      final movies = await _appRemoteDataSource.fetchSearchMovies(pageNo, name);
      return movies.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

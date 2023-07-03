import 'package:cm_movie/src/data/datasources/remotes/app_remote_datasource.dart';
import 'package:cm_movie/src/data/mappers/mapper.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/series_repository.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final AppRemoteDataSource _dataSource;

  const SeriesRepositoryImpl(this._dataSource);

  @override
  Future<List<Movie>> fetchSeries(int pageNo) async {
    try {
      final response = await _dataSource.fetchSeries(pageNo);
      return response.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Could not fetch Series');
    }
  }

  @override
  Future<Movie> fetchSeriesDetail(Movie movie) async {
    try {
      final movieDTO = Mapper.movieToMovieDTO(movie);
      final response = await _dataSource.fetchDetail(movieDTO);
      return response.toEntity();
    } catch (e) {
      throw Exception('Could not fetch series detail');
    }
  }
}

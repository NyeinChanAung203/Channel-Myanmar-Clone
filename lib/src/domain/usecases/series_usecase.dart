import 'package:cm_movie/src/data/repositories/series_repository_impl.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class SeriesUseCase {
  Future<List<Movie>> getAll(int pageNo);
  Future<Movie> getDetail(Movie movie);
}

class SeriesUseCaseImpl extends SeriesUseCase {
  SeriesUseCaseImpl(this._seriesRepositoryImpl);

  final SeriesRepositoryImpl _seriesRepositoryImpl;

  @override
  Future<List<Movie>> getAll(int pageNo) async {
    return await _seriesRepositoryImpl.fetchSeries(pageNo);
  }

  @override
  Future<Movie> getDetail(Movie movie) async {
    return await _seriesRepositoryImpl.fetchSeriesDetail(movie);
  }
}

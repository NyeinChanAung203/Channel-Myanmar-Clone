import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/series_repository.dart';

abstract class SeriesUseCase {
  Future<List<Movie>> getAll(int pageNo);
  Future<Movie> getDetail(Movie movie);
}

class SeriesUseCaseImpl extends SeriesUseCase {
  SeriesUseCaseImpl(this._seriesRepository);

  final SeriesRepository _seriesRepository;

  @override
  Future<List<Movie>> getAll(int pageNo) async {
    return await _seriesRepository.fetchSeries(pageNo);
  }

  @override
  Future<Movie> getDetail(Movie movie) async {
    return await _seriesRepository.fetchSeriesDetail(movie);
  }
}

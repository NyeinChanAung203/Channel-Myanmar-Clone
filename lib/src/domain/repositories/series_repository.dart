import 'package:cm_movie/src/domain/entities/movie.dart';

abstract class SeriesRepository {
  Future<List<Movie>> fetchSeries(int pageNo);
  Future<Movie> fetchSeriesDetail(Movie movie);
}

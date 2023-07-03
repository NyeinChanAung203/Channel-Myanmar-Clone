import 'dart:async';
import 'dart:developer';

import 'package:cm_movie/src/data/datasources/remotes/app_remote_datasource.dart';
import 'package:cm_movie/src/data/mappers/mapper.dart';

import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final AppRemoteDataSource _dataSource;

  const MovieRepositoryImpl(this._dataSource);

  @override
  Future<Movie> fetchMovieDetail(Movie movie) async {
    try {
      final movieDto = Mapper.movieToMovieDTO(movie);

      final response = await _dataSource.fetchDetail(movieDto);
      log('response $response');
      return response.toEntity();
    } catch (e) {
      throw Exception('Could not fetch movie detail');
    }
  }

  @override
  Future<List<Movie>> fetchMovies(int pageNo) async {
    try {
      final response = await _dataSource.fetchMovies(pageNo);
      return response.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Could not fetch movies');
    }
  }
}

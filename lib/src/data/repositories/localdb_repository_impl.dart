import 'package:cm_movie/src/data/datasources/locals/localdatabase.dart';
import 'package:cm_movie/src/data/mappers/mapper.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:cm_movie/src/domain/repositories/localdb_repository.dart';

class LocaldbRepositoryImpl implements LocalDBRepository {
  final LocalDatabase _localDatabase;

  const LocaldbRepositoryImpl(this._localDatabase);

  @override
  void addMovieToFavorite(Movie movie) {
    _localDatabase.addMovie(Mapper.movieToMovieDTO(movie));
  }
}

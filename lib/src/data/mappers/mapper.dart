import 'package:cm_movie/src/data/models/link_dto.dart';
import 'package:cm_movie/src/data/models/movie_dto.dart';
import 'package:cm_movie/src/domain/entities/link_entity.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';

import '../../domain/entities/genre.dart';
import '../models/genre_dto.dart';

class Mapper {
  static MovieDTO movieToMovieDTO(Movie movie) {
    final movidDto = MovieDTO(
        title: movie.title,
        imgUrl: movie.imgUrl,
        url: movie.url,
        descriptions: movie.descriptions,
        links: movie.links?.map((e) => linkEntitytoLinkDTO(e)).toList(),
        rating: movie.rating);

    return movidDto;
  }

  static GenreDTO genreToGenreDto(Genre genre) {
    return GenreDTO(name: genre.name, url: genre.url, total: genre.total);
  }

  static LinkDTO linkEntitytoLinkDTO(LinkEntity linkEntity) {
    return LinkDTO(
        name: linkEntity.name,
        url: linkEntity.url,
        quality: linkEntity.quality,
        fileSize: linkEntity.fileSize);
  }
}

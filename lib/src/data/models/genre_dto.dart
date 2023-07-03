import 'package:cm_movie/src/domain/entities/genre.dart';

class GenreDTO {
  final String name;
  final String url;
  final String total;

  const GenreDTO({required this.name, required this.url, required this.total});

  Genre toEntity() {
    return Genre(name: name, url: url, total: total);
  }
}

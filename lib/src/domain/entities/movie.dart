import 'package:cm_movie/src/domain/entities/link_entity.dart';

class Movie {
  String title;

  String imgUrl;

  String url;

  String rating;

  List<LinkEntity>? links;

  List<String>? descriptions;

  Movie({
    required this.title,
    required this.imgUrl,
    required this.url,
    this.rating = '',
    this.links,
    this.descriptions,
  });
}

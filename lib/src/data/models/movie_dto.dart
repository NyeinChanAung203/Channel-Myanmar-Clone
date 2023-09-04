import 'package:cm_movie/src/data/models/link_dto.dart';
import 'package:cm_movie/src/domain/entities/movie.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class MovieDTO extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String imgUrl;

  @HiveField(2)
  String url;

  @HiveField(3)
  String rating;

  @HiveField(4)
  List<LinkDTO>? links;

  @HiveField(5)
  List<String>? descriptions;

  MovieDTO({
    required this.title,
    required this.imgUrl,
    required this.url,
    this.rating = '',
    this.links,
    this.descriptions,
  });

  toMap() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'url': url,
      'rating': rating,
      'links': links,
      'descriptions': descriptions
    };
  }

  Movie toEntity() => Movie(
      title: title,
      imgUrl: imgUrl,
      url: url,
      descriptions: descriptions,
      links: links?.map((e) => e.toEntity()).toList(),
      rating: rating);

  factory MovieDTO.fromEntity(Movie movie) {
    return MovieDTO(
        title: movie.title,
        imgUrl: movie.imgUrl,
        url: movie.url,
        descriptions: movie.descriptions,
        links: movie.links?.map((e) => LinkDTO.fromEntity(e)).toList(),
        rating: movie.rating);
  }

  factory MovieDTO.fromJson(Map json) {
    return MovieDTO(
        title: json['title'],
        imgUrl: json['imgUrl'],
        url: json['url'],
        rating: json['rating'],
        links: json['links'],
        descriptions: json['descriptions']);
  }

  @override
  String toString() =>
      "Movie(title: $title,imgUrl: $imgUrl,url: $url,rating $rating,links $links,description: $descriptions)";
}

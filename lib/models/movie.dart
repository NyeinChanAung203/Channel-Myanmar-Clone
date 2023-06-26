import 'package:cm_movie/models/link.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String imgUrl;

  @HiveField(2)
  String url;

  @HiveField(3)
  String rating;

  @HiveField(4)
  List<LinkModel>? links;

  @HiveField(5)
  List<String>? descriptions;

  Movie({
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

  factory Movie.fromJson(Map json) {
    return Movie(
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

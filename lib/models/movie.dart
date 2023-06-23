import 'package:cm_movie/models/link.dart';

class Movie {
  final String title;
  final String imgUrl;
  final String url;
  final String rating;
  List<LinkModel>? links;
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
}

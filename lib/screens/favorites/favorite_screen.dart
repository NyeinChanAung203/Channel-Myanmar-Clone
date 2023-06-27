import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/screens/movies/movie_detail.dart';
import 'package:cm_movie/screens/tvshows/series_detail.dart';

import 'package:cm_movie/services/boxes.dart';
import 'package:cm_movie/themes/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: ValueListenableBuilder(
            valueListenable: Boxes.getMovieBox().listenable(),
            builder: (context, box, child) {
              final movies =
                  box.values.toList().cast<Movie>().reversed.toList();
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 0.1,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (movies[index].url.contains('tvshows')) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SeriesDetailScreen(movie: movies[index])));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: movies[index])));
                      }
                    },
                    trailing: IconButton(
                        color: kWhite.withOpacity(0.8),
                        onPressed: () {
                          movies[index].delete();
                        },
                        icon: const Icon(Icons.delete)),
                    leading: CachedNetworkImage(
                      imageUrl: movies[index].imgUrl,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(
                        radius: 10,
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      movies[index].title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                itemCount: movies.length,
              );
            }),
      ),
    );
  }
}

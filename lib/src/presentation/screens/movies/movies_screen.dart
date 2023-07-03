import 'package:cached_network_image/cached_network_image.dart';

import 'package:cm_movie/src/presentation/providers/movie_provider.dart';
import 'package:cm_movie/src/presentation/screens/movies/movie_detail.dart';
import 'package:cm_movie/src/config/themes/styles.dart';

import 'package:cm_movie/src/presentation/widgets/shrimmer_search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 18,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Movies'),
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<MovieProvider>().fetchMovie(pageNumber: 1);
              },
              icon: const Icon(Icons.replay))
        ],
      ),
      body: Column(
        children: [
          context.watch<MovieProvider>().loading
              ? const ShimmerSearchWidget()
              : Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 8 / 11,
                      ),
                      itemCount: movieProvider.movies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                    movie: movieProvider.movies[index])));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GridTile(
                              header: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8))),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: kYellow,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          movieProvider.movies[index].rating,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(color: kYellow),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              footer: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.black87,
                                ),
                                child: Text(
                                  movieProvider.movies[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: movieProvider.movies[index].imgUrl,
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
                            ),
                          ),
                        );
                      }),
                ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page ${context.watch<MovieProvider>().pageNo}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          await context.read<MovieProvider>().backPage();
                        },
                        icon: const Icon(Icons.arrow_circle_left)),
                    IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          await context.read<MovieProvider>().nextPage();
                        },
                        icon: const Icon(Icons.arrow_circle_right)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

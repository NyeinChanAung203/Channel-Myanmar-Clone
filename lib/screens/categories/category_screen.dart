import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/providers/genre_provider.dart';
import 'package:cm_movie/widgets/shrimmer_search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/styles.dart';
import '../movies/movie_detail.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<GenreProvider>().genres.isEmpty) {
      Future.microtask(() => context.read<GenreProvider>().fetchGenres());
    }
  }

  @override
  Widget build(BuildContext context) {
    final genreProvider = context.watch<GenreProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
      ),
      body: Column(
        children: [
          SizedBox(
            // color: Colors.blue,
            height: 66,
            child: ListView.builder(
              key: PageStorageKey(genreProvider.genres),
              scrollDirection: Axis.horizontal,
              itemCount: genreProvider.genres.length,
              itemBuilder: (context, index) {
                final genre = context.watch<GenreProvider>().genres[index];
                return GestureDetector(
                  onTap: () async {
                    context.read<GenreProvider>().genreValue =
                        genre.name.toLowerCase();
                    await context
                        .read<GenreProvider>()
                        .fetchMovieByGenre(pageNumber: 1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            genreProvider.genreValue == genre.name.toLowerCase()
                                ? kYellow
                                : Colors.black12,
                        borderRadius: BorderRadius.circular(50)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          genre.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: genreProvider.genreValue ==
                                      genre.name.toLowerCase()
                                  ? FontWeight.bold
                                  : null,
                              color: genreProvider.genreValue ==
                                      genre.name.toLowerCase()
                                  ? kBlack
                                  : Colors.white),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          genre.total,
                          style: TextStyle(
                              fontWeight: genreProvider.genreValue ==
                                      genre.name.toLowerCase()
                                  ? FontWeight.bold
                                  : null,
                              color: genreProvider.genreValue ==
                                      genre.name.toLowerCase()
                                  ? kBlack
                                  : Colors.white),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          genreProvider.loading && genreProvider.genres.isNotEmpty
              ? const ShimmerSearchWidget()
              : Expanded(
                  child: genreProvider.movies.isEmpty
                      ? const Center(
                          child: Text('No Content Available'),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 8 / 11,
                          ),
                          itemCount: genreProvider.movies.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                        movie: genreProvider.movies[index])));
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
                                                bottomLeft:
                                                    Radius.circular(8))),
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
                                              '99',
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
                                      genreProvider.movies[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        genreProvider.movies[index].imgUrl,
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
          if (genreProvider.movies.isNotEmpty ||
              genreProvider.genreValue.isNotEmpty)
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page ${context.watch<GenreProvider>().pageNo}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      IconButton(
                          iconSize: 35,
                          onPressed: () async {
                            await context.read<GenreProvider>().backPage();
                          },
                          icon: const Icon(Icons.arrow_circle_left)),
                      IconButton(
                          iconSize: 35,
                          onPressed: () async {
                            await context.read<GenreProvider>().nextPage();
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

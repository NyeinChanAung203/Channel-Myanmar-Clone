import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/screens/series_detail.dart';
import 'package:cm_movie/screens/series_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';
import '../providers/series_provider.dart';
import '../themes/styles.dart';
import '../widgets/shimmer_home_widget.dart';
import 'movie_detail.dart';
import 'movies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kYellow,
      onRefresh: () async {
        await Future.wait([
          context.read<MovieProvider>().fetchMovie(pageNumber: 1),
          context.read<SeriesProvider>().fetchSeries(pageNumber: 1),
        ]);
      },
      child: context.watch<MovieProvider>().loading ||
              context.watch<SeriesProvider>().loading
          ? const ShimmerHomeWidget()
          : ListView(
              padding: const EdgeInsets.only(left: 10),
              primary: true,
              shrinkWrap: true,
              children: [
                TitleBarWidget(
                  title: 'Movies',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MoviesScreen()));
                  },
                ),
                const MoviesListWidget(),
                TitleBarWidget(
                    title: 'Tv Shows',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SeriesScreen()));
                    }),
                const SeriesListWidget(),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
    );
  }
}

class SeriesListWidget extends StatelessWidget {
  const SeriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: context.watch<SeriesProvider>().series.length,
        itemBuilder: (context, index) {
          final movie = context.watch<SeriesProvider>().series[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SeriesDetailScreen(movie: movie)));
            },
            child: Container(
              height: 270,
              width: 160,
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: movie.imgUrl,
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
                  Expanded(
                    flex: 1,
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: kWhite),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: context.watch<MovieProvider>().movies.length,
        itemBuilder: (context, index) {
          final movie = context.watch<MovieProvider>().movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie)));
            },
            child: Container(
              height: 270,
              width: 160,
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: movie.imgUrl,
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
                  Expanded(
                    flex: 1,
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: kWhite),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TitleBarWidget extends StatelessWidget {
  const TitleBarWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kWhite),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              'See All',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: kYellow,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/providers/movie_provider.dart';
import 'package:cm_movie/services/boxes.dart';

import 'package:cm_movie/themes/styles.dart';
import 'package:cm_movie/utils/select_link_image.dart';
import 'package:cm_movie/widgets/shimmer_detail_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieProvider>().detailMovie(widget.movie));
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: movieProvider.loading || movieProvider.movieDetail == null
            ? AppBar(
                backgroundColor: kBlack,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                  iconSize: 18,
                ),
                actions: const [
                  IconButton.filled(
                      onPressed: null,
                      iconSize: 20,
                      color: kWhite,
                      icon: Icon(Icons.star_rounded))
                ],
              )
            : null,
        body: movieProvider.loading || movieProvider.movieDetail == null
            ? const ShimmerDetailWidget()
            : CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leading: IconButton.filled(
                        iconSize: 18,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios)),
                    actions: [
                      IconButton.filled(
                          onPressed: () {
                            if (movieProvider.movieDetail != null) {
                              Boxes.addMovie(movieProvider.movieDetail!);
                            }
                          },
                          iconSize: 20,
                          color: kWhite,
                          icon: const Icon(Icons.star_rounded))
                    ],
                    backgroundColor: kBlack,
                    expandedHeight: 300,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        widget.movie.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      centerTitle: false,
                      background: movieProvider.movieDetail?.imgUrl != null
                          ? CachedNetworkImage(
                              imageUrl: movieProvider.movieDetail?.imgUrl ?? '',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                radius: 10,
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : null,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        /// Description
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: movieProvider.movieDetail!.descriptions!
                                .map((e) => Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: kWhite),
                                    ))
                                .toList(),
                          ),
                        ),

                        /// Links
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final linkModel =
                                    movieProvider.movieDetail!.links![index];
                                return ListTile(
                                  dense: true,
                                  titleTextStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => WebViewApp(
                                    //             url: linkModel.url)));
                                    launchUrl(Uri.parse(linkModel.url),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  leading: Image.asset(
                                      selectLinkImage(linkModel.name)),
                                  title: Text(linkModel.name),
                                  subtitle: Text(
                                    linkModel.quality,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                  trailing: Text(linkModel.fileSize),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 0.1,
                                );
                              },
                              itemCount:
                                  movieProvider.movieDetail!.links!.length),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

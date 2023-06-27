import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/models/movie.dart';

import 'package:cm_movie/providers/series_provider.dart';

import 'package:cm_movie/themes/styles.dart';
import 'package:cm_movie/widgets/shimmer_detail_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/boxes.dart';

class SeriesDetailScreen extends StatefulWidget {
  const SeriesDetailScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<SeriesDetailScreen> createState() => _SeriesDetailScreenState();
}

class _SeriesDetailScreenState extends State<SeriesDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<SeriesProvider>().detailSeries(widget.movie));
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<SeriesProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: movieProvider.loading || movieProvider.seriesDetail == null
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
                      icon: Icon(Icons.favorite))
                ],
              )
            : null,
        body: movieProvider.loading || movieProvider.seriesDetail == null
            ? const ShimmerDetailWidget()
            : CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    actions: [
                      IconButton.filled(
                          onPressed: () {
                            if (movieProvider.seriesDetail != null) {
                              Boxes.addMovie(movieProvider.seriesDetail!);
                            }
                          },
                          iconSize: 20,
                          color: kWhite,
                          icon: const Icon(Icons.favorite))
                    ],
                    leading: IconButton.filled(
                        iconSize: 18,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios)),
                    backgroundColor: const Color.fromARGB(255, 31, 33, 40),
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
                      background: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl:
                                  movieProvider.seriesDetail?.imgUrl ?? '',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [
                                  0.5,
                                  0.85,
                                  1,
                                ],
                                    colors: [
                                  Colors.transparent,
                                  kBlack.withOpacity(0.88),
                                  kBlack,
                                ])),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        /// Description
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: movieProvider.seriesDetail!.descriptions!
                                .map((e) {
                              if (e.trim().isNotEmpty) {
                                return Text(
                                  e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: kWhite),
                                );
                              }
                              return const SizedBox.shrink();
                            }).toList(),
                          ),
                        ),
                        const Divider(
                          thickness: 0.2,
                        ),
                        Text(
                          'Sorry! Cannot generate links for TV Shows :(',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kYellow,
                              foregroundColor: kBlack,
                            ),
                            onPressed: () {
                              launchUrl(
                                  Uri.parse(movieProvider.seriesDetail!.url),
                                  mode: LaunchMode.externalApplication,
                                  webViewConfiguration:
                                      const WebViewConfiguration(
                                    enableJavaScript: false,
                                    enableDomStorage: false,
                                  ));
                            },
                            icon: const Icon(Icons.web),
                            label: const Text('Go To Website')),
                        const SizedBox(
                          height: 20,
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

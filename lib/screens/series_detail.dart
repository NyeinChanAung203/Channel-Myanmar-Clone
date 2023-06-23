import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/models/movie.dart';

import 'package:cm_movie/providers/series_provider.dart';

import 'package:cm_movie/themes/styles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                  iconSize: 18,
                ),
              )
            : null,
        body: movieProvider.loading || movieProvider.seriesDetail == null
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.8),
                child: const CupertinoActivityIndicator(
                  color: kWhite,
                  radius: 12,
                ),
              )
            : CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leading: IconButton.filled(
                        iconSize: 18,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios)),
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
                      background: CachedNetworkImage(
                        imageUrl: movieProvider.seriesDetail?.imgUrl ?? '',
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
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        /// Description
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: movieProvider.seriesDetail!.descriptions!
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
                        const Divider(
                          thickness: 0.2,
                        ),
                        Text(
                          'Sorry! We can generate links for Tv Shows :(',
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

                        /// Links
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: ListView.separated(
                        //       shrinkWrap: true,
                        //       primary: false,
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       itemBuilder: (context, index) {
                        //         final linkModel =
                        //             movieProvider.seriesDetail!.links![index];
                        //         return ListTile(
                        //           dense: true,
                        //           titleTextStyle:
                        //               Theme.of(context).textTheme.labelLarge,
                        //           onTap: () {
                        //             // Navigator.of(context).push(
                        //             //     MaterialPageRoute(
                        //             //         builder: (context) => WebViewApp(
                        //             //             url: linkModel.url)));
                        //             launchUrl(Uri.parse(linkModel.url),
                        //                 mode: LaunchMode.externalApplication);
                        //           },
                        //           leading: Image.asset(
                        //               selectLinkImage(linkModel.name)),
                        //           title: Text(linkModel.name),
                        //           subtitle: Text(
                        //             linkModel.quality,
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .labelSmall
                        //                 ?.copyWith(color: Colors.white70),
                        //           ),
                        //           trailing: Text(linkModel.fileSize),
                        //         );
                        //       },
                        //       separatorBuilder: (context, index) {
                        //         return const Divider(
                        //           thickness: 0.1,
                        //         );
                        //       },
                        //       itemCount:
                        //           movieProvider.seriesDetail!.links!.length),
                        // )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

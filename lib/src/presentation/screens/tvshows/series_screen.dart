import 'package:cached_network_image/cached_network_image.dart';

import 'package:cm_movie/src/presentation/providers/series_provider.dart';
import 'package:cm_movie/src/presentation/screens/tvshows/series_detail.dart';

import 'package:cm_movie/src/presentation/widgets/shrimmer_search_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seriesProvider = context.watch<SeriesProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 18,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Tv Shows'),
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<SeriesProvider>().fetchSeries(pageNumber: 1);
              },
              icon: const Icon(Icons.replay))
        ],
      ),
      body: Column(
        children: [
          context.watch<SeriesProvider>().loading
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
                      itemCount: seriesProvider.series.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SeriesDetailScreen(
                                    movie: seriesProvider.series[index])));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GridTile(
                              header: seriesProvider
                                      .series[index].rating.isNotEmpty
                                  ? Row(
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
                                          child: Text(
                                            seriesProvider.series[index].rating,
                                            style: const TextStyle(
                                                color: Colors.yellow),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              footer: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  decoration: const BoxDecoration(
                                    color: Colors.black87,
                                  ),
                                  child: Text(
                                    seriesProvider.series[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              child: CachedNetworkImage(
                                imageUrl: seriesProvider.series[index].imgUrl,
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
                  'Page ${context.watch<SeriesProvider>().pageNo}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          await context.read<SeriesProvider>().backPage();
                        },
                        icon: const Icon(Icons.arrow_circle_left)),
                    IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          await context.read<SeriesProvider>().nextPage();
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

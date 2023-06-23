import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_movie/providers/search_provider.dart';
import 'package:cm_movie/screens/movie_detail.dart';
import 'package:cm_movie/themes/styles.dart';
import 'package:cm_movie/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 18,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: context.read<SearchProvider>().name,
            textInputAction: TextInputAction.done,
            cursorColor: kWhite,
            cursorHeight: 25,
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintText: ' Search',
                border:
                    OutlineInputBorder(borderSide: BorderSide(color: kBlack)),
                isDense: true,
                fillColor: kBlack,
                filled: true,
                disabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: kBlack)),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: kBlack))),
            onEditingComplete: () async {
              if (context.read<SearchProvider>().name.text.trim().isNotEmpty) {
                await context.read<SearchProvider>().fetchSearchMovie();
              }
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (context
                    .read<SearchProvider>()
                    .name
                    .text
                    .trim()
                    .isNotEmpty) {
                  await context.read<SearchProvider>().fetchSearchMovie();
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              context.watch<SearchProvider>().searchedMovies.isEmpty
                  ? const Expanded(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text('No content available'),
                      ],
                    ))
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
                          itemCount: searchProvider.searchedMovies.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                        movie: searchProvider
                                            .searchedMovies[index])));
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
                                              searchProvider
                                                  .searchedMovies[index].rating,
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
                                      searchProvider
                                          .searchedMovies[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: searchProvider
                                        .searchedMovies[index].imgUrl,
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
                      'Page ${context.watch<SearchProvider>().pageNo}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              await context.read<SearchProvider>().backPage();
                            },
                            icon: const Icon(Icons.arrow_circle_left)),
                        IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              await context.read<SearchProvider>().nextPage();
                            },
                            icon: const Icon(Icons.arrow_circle_right)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          context.watch<SearchProvider>().loading
              ? const LoadingWidget()
              : const SizedBox()
        ],
      ),
    );
  }
}

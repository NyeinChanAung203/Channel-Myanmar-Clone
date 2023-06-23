import 'package:cm_movie/providers/bottom_nav_provider.dart';

import 'package:cm_movie/providers/movie_provider.dart';
import 'package:cm_movie/providers/search_provider.dart';

import 'package:cm_movie/providers/series_provider.dart';
import 'package:cm_movie/screens/search_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/movie.dart';

class BottonNavScreen extends StatefulWidget {
  const BottonNavScreen({super.key});

  @override
  State<BottonNavScreen> createState() => _BottonNavScreenState();
}

class _BottonNavScreenState extends State<BottonNavScreen> {
  List<Movie> movies = [];
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Future.wait([
        context.read<MovieProvider>().fetchMovie(),
        context.read<SeriesProvider>().fetchSeries(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, botnavProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () async {
                await Future.wait([
                  context.read<MovieProvider>().fetchMovie(pageNumber: 1),
                  context.read<SeriesProvider>().fetchSeries(pageNumber: 1)
                ]);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/cm.png',
                  fit: BoxFit.contain,
                  scale: 0.3,
                ),
              ),
            ),
            title: const Text('Channel Myanmar'),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SearchProvider>().resetState();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: botnavProvider.pages[botnavProvider.index],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              currentIndex: botnavProvider.index,
              onTap: botnavProvider.changeIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: 'Favorites'),
              ]),
        );
      },
    );
  }
}

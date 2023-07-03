import 'package:cm_movie/src/presentation/providers/bottom_nav_provider.dart';

import 'package:cm_movie/src/presentation/providers/movie_provider.dart';

import 'package:cm_movie/src/presentation/providers/series_provider.dart';
import 'package:cm_movie/src/config/themes/styles.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../providers/genre_provider.dart';

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
        context.read<GenreProvider>().fetchGenres(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, botnavProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            bool result = false;
            if (botnavProvider.index != 0) {
              botnavProvider.changeIndex(0);
            } else if (botnavProvider.index == 1) {
              FocusScope.of(context).unfocus();
            } else if (botnavProvider.index == 0) {
              result = await askExitDialog(context);
            }
            return Future.value(result);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                      icon: Icon(Icons.category), label: 'Genres'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                ]),
          ),
        );
      },
    );
  }

  Future<dynamic> askExitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Icon(Icons.exit_to_app_rounded),
              content: const Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: kWhite,
                      backgroundColor: kBlack,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: kBlack,
                      backgroundColor: kYellow,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes')),
              ],
            ));
  }
}

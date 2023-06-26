import 'package:cm_movie/models/link.dart';
import 'package:cm_movie/models/movie.dart';
import 'package:cm_movie/providers/bottom_nav_provider.dart';
import 'package:cm_movie/providers/genre_provider.dart';

import 'package:cm_movie/providers/movie_provider.dart';
import 'package:cm_movie/providers/search_provider.dart';
import 'package:cm_movie/providers/series_provider.dart';

import 'package:cm_movie/screens/splash_screen.dart';
import 'package:cm_movie/themes/my_theme.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(LinkModelAdapter());
  await Hive.openBox<Movie>('moviesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => SeriesProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => GenreProvider()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          theme: MyTheme.dark(),
          title: 'Channel Myanmar',
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

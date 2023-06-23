import 'package:cm_movie/providers/bottom_nav_provider.dart';

import 'package:cm_movie/providers/movie_provider.dart';
import 'package:cm_movie/providers/search_provider.dart';
import 'package:cm_movie/providers/series_provider.dart';
import 'package:cm_movie/screens/bottom_nav_screen.dart';
import 'package:cm_movie/themes/my_theme.dart';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
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
        // ChangeNotifierProvider(create: (context) => LatestProvider()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          theme: MyTheme.dark(),
          title: 'Channel Myanmar',
          home: const BottonNavScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

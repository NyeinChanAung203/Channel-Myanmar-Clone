import 'package:cm_movie/src/data/datasources/locals/localdatabase.dart';
import 'package:cm_movie/src/data/datasources/remotes/app_remote_datasource.dart';
import 'package:cm_movie/src/data/models/link_dto.dart';
import 'package:cm_movie/src/data/repositories/genre_repository_impl.dart';
import 'package:cm_movie/src/data/repositories/localdb_repository_impl.dart';
import 'package:cm_movie/src/data/repositories/movie_repository_impl.dart';
import 'package:cm_movie/src/data/repositories/search_repository_impl.dart';
import 'package:cm_movie/src/data/repositories/series_repository_impl.dart';
import 'package:cm_movie/src/domain/usecases/genre_usecase.dart';
import 'package:cm_movie/src/domain/usecases/localdb_usecase.dart';

import 'package:cm_movie/src/domain/usecases/movie_usecase.dart';
import 'package:cm_movie/src/domain/usecases/search_usecase.dart';
import 'package:cm_movie/src/domain/usecases/series_usecase.dart';
import 'package:cm_movie/src/presentation/providers/bottom_nav_provider.dart';
import 'package:cm_movie/src/presentation/providers/genre_provider.dart';
import 'package:cm_movie/src/presentation/providers/localdb_provider.dart';

import 'package:cm_movie/src/presentation/providers/movie_provider.dart';
import 'package:cm_movie/src/presentation/providers/search_provider.dart';

import 'package:cm_movie/src/presentation/providers/series_provider.dart';

import 'package:cm_movie/src/presentation/screens/splash_screen.dart';
import 'package:cm_movie/src/config/themes/my_theme.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'src/data/models/movie_dto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(LinkModelAdapter());
  await Hive.openBox<MovieDTO>('moviesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(
            create: (context) => MovieProvider(MovieUseCaseImpl(
                const MovieRepositoryImpl(AppRemoteDataSource())))),
        ChangeNotifierProvider(
            create: (context) => SeriesProvider(SeriesUseCaseImpl(
                const SeriesRepositoryImpl(AppRemoteDataSource())))),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
              SearchUseCaseImpl(
                const SearchRepositoryImpl(AppRemoteDataSource()),
              ),
              MovieUseCaseImpl(
                  const MovieRepositoryImpl(AppRemoteDataSource()))),
        ),
        ChangeNotifierProvider(
            create: (context) => GenreProvider(GenreUseCaseImpl(
                const GenreRepositoryImpl(AppRemoteDataSource())))),
        ChangeNotifierProvider(
            create: (context) => LocalDBProvider(
                LocalDBUseCaseImpl(LocaldbRepositoryImpl(LocalDatabase()))))
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

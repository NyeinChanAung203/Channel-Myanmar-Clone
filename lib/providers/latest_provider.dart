// import 'dart:developer';

// import 'package:cm_movie/models/movie.dart';
// import 'package:cm_movie/services/app_services.dart';
// import 'package:flutter/material.dart';

// class LatestProvider extends ChangeNotifier {
//   bool loading = false;
//   int pageNo = 1;

//   setLoading() {
//     loading = true;
//     notifyListeners();
//   }

//   removeLoading() {
//     loading = false;
//     notifyListeners();
//   }

//   List<Movie> latestMovies = [];

//   Future<void> fetchLatestMovie() async {
//     try {
//       setLoading();
//       await AppService.fetchLatestMovies().then((movieList) {
//         latestMovies = movieList;
//         removeLoading();
//       });
//     } catch (e) {
//       log('fetch latestMovies error $e');
//       removeLoading();
//     }
//   }
// }

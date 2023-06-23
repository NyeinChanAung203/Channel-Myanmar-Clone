import 'package:cm_movie/themes/styles.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData dark() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kBlack,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: kBlack,
        onPrimary: kWhite,
        secondary: kYellow,
      ));
}

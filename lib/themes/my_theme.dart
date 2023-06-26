import 'package:cm_movie/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData dark() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kBlack,
      fontFamily: GoogleFonts.average().fontFamily,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: kBlack,
        onPrimary: kWhite,
        secondary: kYellow,
      ));
}

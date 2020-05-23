import 'package:flutter/material.dart' show Brightness, FloatingActionButtonThemeData, FontWeight, IconThemeData, TextTheme, ThemeData, VisualDensity;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:prayertimes/ui/helper/AppColors.dart' show AppColors;

final themeDarkData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  primaryColor: AppColors.colorDarkPrimary,
  accentColor: AppColors.colorDarkSecondary,
  backgroundColor: AppColors.colorDarkSecondary,
  splashColor: AppColors.colorDarkThird,
  highlightColor: AppColors.colorDarkThird,
  cardColor: AppColors.colorDarkPrimary,
  dividerColor: AppColors.colorDarkThird,
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.colorStarted, elevation: 2),
  iconTheme: IconThemeData(color: AppColors.colorDarkThird, size: 24),
  textTheme: TextTheme(
    button: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorDarkTitle),
    headline3: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorDarkTitle),
    headline4: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorDarkTitle, fontSize: 24),
    headline5: GoogleFonts.openSans(fontWeight: FontWeight.w500, color: AppColors.colorStartedDescription, fontSize: 14),
    headline6: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorDarkTitle),
    subtitle2: GoogleFonts.openSans(fontWeight: FontWeight.w500, color: AppColors.colorDarkTitle, fontSize: 13),
  ),
);

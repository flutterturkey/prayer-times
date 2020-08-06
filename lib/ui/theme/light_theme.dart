import 'package:flutter/material.dart' show Brightness, FloatingActionButtonThemeData, FontWeight, IconThemeData, TextTheme, ThemeData, VisualDensity;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:prayertimes/ui/helper/AppColors.dart' show AppColors;

final themeLightData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  primaryColor: AppColors.colorLightPrimary,
  accentColor: AppColors.colorLightSecondary,
  backgroundColor: AppColors.colorLightSecondary,
  primaryColorDark: AppColors.colorDarkPrimary,
  splashColor: AppColors.colorLightSecondary,
  highlightColor: AppColors.colorLightSecondary,
  cardColor: AppColors.colorLightCardColors,
  dividerColor: AppColors.colorLightPrimary,
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.colorStarted, elevation: 2),
  iconTheme: IconThemeData(color: AppColors.colorLightPrimary, size: 24),
  textTheme: TextTheme(
    button: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    headline3: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    headline4: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary, fontSize: 24),
    headline5: GoogleFonts.openSans(fontWeight: FontWeight.w500, color: AppColors.colorStartedDescription, fontSize: 14),
    headline6: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    subtitle1: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary, fontSize: 16),
    subtitle2: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary, fontSize: 16)
  ),
);

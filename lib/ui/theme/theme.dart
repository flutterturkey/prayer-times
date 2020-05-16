import 'package:flutter/material.dart' show FloatingActionButtonThemeData, FontWeight, IconThemeData, TextTheme, ThemeData;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:prayertimes/ui/helper/AppColors.dart' show AppColors;

final themeData = ThemeData(
  primaryColor: AppColors.colorLightPrimary,
  accentColor: AppColors.colorLightSecondary,
  backgroundColor: AppColors.colorLightSecondary,
  primaryColorDark: AppColors.colorDarkPrimary,
  splashColor: AppColors.colorLightPrimary,
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.colorStarted, elevation: 2),
  iconTheme: IconThemeData(color: AppColors.colorLightPrimary, size: 24),
  textTheme: TextTheme(
    button: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    headline3: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    headline4: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorStartedTitle, fontSize: 32),
    headline5: GoogleFonts.openSans(fontWeight: FontWeight.w500, color: AppColors.colorStartedDescription, fontSize: 14),
    headline6: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: AppColors.colorLightPrimary),
    subtitle2: GoogleFonts.openSans(fontWeight: FontWeight.w500, color: AppColors.colorLightPrimary, fontSize: 13),
  ),
);

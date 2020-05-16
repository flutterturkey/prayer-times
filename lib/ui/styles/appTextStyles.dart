import 'package:flutter/material.dart' show FontWeight, TextStyle;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:prayertimes/ui/helper/AppColors.dart' show AppColors;

class AppTextStyles {
  static TextStyle get appBarTextStyles => GoogleFonts.openSans(color: AppColors.colorLightPrimary, fontSize: 24, fontWeight: FontWeight.bold);
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mdi/mdi.dart';

import 'AppColors.dart';

class AppIcons {
  // Icons
  static final IconData location = Icons.location_on;
  static final IconData home = Icons.home;
  static final IconData notification = Icons.notifications;
  static final IconData settings = Icons.settings;
  static final IconData navigateNext = Icons.navigate_next;
  static final IconData dropdown = Icons.arrow_drop_down;
  static final IconData moon = Mdi.moonWaningCrescent;
  static final SvgPicture imsak = SvgPicture.asset(imsakSVG, color: AppColors.colorLightPrimary, height: 17);
  static final SvgPicture sun = SvgPicture.asset(sunSVG, color: AppColors.colorLightPrimary, height: 17);
  static final SvgPicture noon = SvgPicture.asset(noonSVG, color: AppColors.colorLightPrimary, height: 17);
  static final SvgPicture afternoon = SvgPicture.asset(afternoonSVG, color: AppColors.colorLightPrimary, height: 17);
  static final SvgPicture evening = SvgPicture.asset(eveningSVG, color: AppColors.colorLightPrimary, height: 17);
  // #Icons

  // Svg icon path
  static const String imsakSVG = "assets/svg/imsak.svg";
  static const String sunSVG = "assets/svg/sunrise.svg";
  static const String noonSVG = "assets/svg/sun.svg";
  static const String afternoonSVG = "assets/svg/sunFill.svg";
  static const String eveningSVG = "assets/svg/sunset.svg";
  // #Svg icon path

}

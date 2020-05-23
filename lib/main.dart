import 'package:easy_localization/easy_localization.dart' show EasyLocalization;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:prayertimes/screens/splash_screen.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Provider;

import 'package:prayertimes/ui/helper/AppConstants.dart' show AppConstants;
import 'package:prayertimes/ui/theme/dark_theme.dart' show themeDarkData;
import 'package:prayertimes/ui/theme/light_theme.dart' show themeLightData;

import 'models/custom_theme_mode.dart' show CustomThemeMode;
import 'screens/home_page.dart' show HomePage;
import 'screens/onboarding_page.dart' show OnboardingPage;
import 'ui/helper/AppStrings.dart' show AppStrings;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: [
        AppConstants.TR_LOCALE,
        AppConstants.EN_LOCALE,
      ],
      path: AppConstants.LANG_PATH,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => CustomThemeMode()),
        ],
        child: PrayerTimes(),
      ),
    ),
  );
}

class PrayerTimes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr'); //TODO: create AppConstant.languageCode for locale and set 
    return MaterialApp(
      title: AppStrings.appName,
      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: Provider.of<CustomThemeMode>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => CustomSplashScreen(),
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
      },
    );
  }
}

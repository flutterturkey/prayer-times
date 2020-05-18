import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, ThemeMode, Widget, WidgetsFlutterBinding, runApp;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;

import 'screens/home_page.dart' show HomePage;
import 'screens/onboarding_page.dart' show OnboardingPage;
import 'ui/helper/AppStrings.dart' show AppStrings;
import 'ui/theme/theme.dart' show themeDarkData, themeLightData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(EzanVakti());
}

class EzanVakti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return MaterialApp(
      title: AppStrings.appName,
      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      routes: {
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
      },
    );
  }
}

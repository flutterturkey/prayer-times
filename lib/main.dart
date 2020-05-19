import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, WidgetsFlutterBinding, runApp;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:prayertimes/ui/theme/dark_theme.dart';
import 'package:prayertimes/ui/theme/light_theme.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Provider;

import 'models/custom_theme_mode.dart' show CustomThemeMode;
import 'screens/home_page.dart' show HomePage;
import 'screens/onboarding_page.dart' show OnboardingPage;
import 'ui/helper/AppStrings.dart' show AppStrings;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => CustomThemeMode()),
      ],
      child: EzanVakti(),
    ),
  );
}

class EzanVakti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return MaterialApp(
      title: AppStrings.appName,
      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: Provider.of<CustomThemeMode>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      routes: {
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
      },
    );
  }
}

import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, ThemeMode, Widget, runApp;
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlay;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;

import 'screens/home_page.dart' show HomePage;
import 'ui/helper/AppStrings.dart' show AppStrings;
import 'ui/theme/theme.dart' show themeData;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    initializeDateFormatting('tr');
    return MaterialApp(
      theme: themeData,
      themeMode: ThemeMode.dark,
      darkTheme: themeData,
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

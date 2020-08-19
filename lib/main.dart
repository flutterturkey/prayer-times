import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prayertimes/screens/splash_screen.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart' show AppConstants;
import 'package:prayertimes/ui/theme/dark_theme.dart' show themeDarkData;
import 'package:prayertimes/ui/theme/light_theme.dart' show themeLightData;
import 'package:prayertimes/ui/helper/local_notifications_helper.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Provider;

import 'generated/locale_keys.g.dart';
import 'models/custom_theme_mode.dart' show CustomThemeMode;
import 'screens/home_page.dart' show HomePage;
import 'screens/onboarding_page.dart' show OnboardingPage;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: [AppConstants.TR_LOCALE, AppConstants.EN_LOCALE, AppConstants.AR_LOCALE],
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
    return MaterialApp(
      title: LocaleKeys.appName.tr(),
      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: Provider.of<CustomThemeMode>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => CustomSplashScreen(),
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
      },
    );
  }
}

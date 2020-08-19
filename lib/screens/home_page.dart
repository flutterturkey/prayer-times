import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:prayertimes/main.dart';
import 'package:prayertimes/models/prayer_time.dart';
import 'package:prayertimes/models/result.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart';
import 'package:prayertimes/ui/widgets/app_bar.dart' show CustomAppBar;
import 'package:prayertimes/ui/widgets/bottomBarWidgets/bottom_bar.dart' show CustomBottomNavigationBar, getAllowSound, getAllowsNotifications;
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;
import 'package:prayertimes/ui/widgets/homePageWidgets/iftarTimeContainer.dart' show IftarTimeContanier;
import 'package:prayertimes/ui/widgets/homePageWidgets/nextPrayerTimeContainer.dart' show NextPrayerTimeContainer;
import 'package:prayertimes/ui/widgets/homePageWidgets/prayerTimeContainer.dart' show PrayerTimeContainer;
import 'package:prayertimes/ui/widgets/homePageWidgets/timeContainer.dart' show TimeContainer;
import 'package:prayertimes/ui/helper/local_notifications_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<DateTime> fullPrayerTime = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatTime = DateFormat('HH:mm');
  SharedPreferences prefs;
  Timer timer;
  int differenceInHoursIftar, differenceInMinutesIftar, differenceInSecIftar, differenceInHoursPrayer, differenceInMinutesPrayer, differenceInSecPrayer;
  String nextPrayer, id, districtName;
  DateTime now, nextPrayerTime, prevMoonTime, nextImsakTime, nextIftarTime, iftarTime;

  List<PrayerTime> prayerResult = [];
  List<String> prayerTime = [];

  Future<void> _getPrayerTimeData(String id) async {
    List<PrayerTime> _prayerTemp = await getPrayerTimeData(id);
    setState(
      () {
        prayerResult = _prayerTemp;
        prayerTime.add(prayerResult[0].imsak);
        prayerTime.add(prayerResult[0].sun);
        prayerTime.add(prayerResult[0].noon);
        prayerTime.add(prayerResult[0].afternoon);
        prayerTime.add(prayerResult[0].evening);
        prayerTime.add(prayerResult[0].moon);
        prayerTime.add(prayerResult[1].imsak);
        prayerTime.add(prayerResult[1].evening);

        fullPrayerTime = [];
        for (var i = 0; i < prayerTime.length; i++) {
          fullPrayerTime.add(formatTime.parse(prayerTime[i]));
        }
      },
    );
  }

  Future<void> _schedulePrayerNotifications() async {
    bool not = await getAllowsNotifications();
    bool sound = await getAllowSound();

    if (not == true && sound == true) {
      schedulePrayerNotificationsWithSound(flutterLocalNotificationsPlugin, fullPrayerTime);
    } else if (not == false && sound == false) {
      turnOffNotifications(flutterLocalNotificationsPlugin);
    } else {
      schedulePrayerNotifications(flutterLocalNotificationsPlugin, fullPrayerTime);
    }
  }

  @override
  void initState() {
    super.initState();
    (() async {
      id = await getPref(AppConstants.keyDistrictId, AppConstants.districtID);
      districtName = await getPref(AppConstants.keyDistrict, AppConstants.districtName);
      await _getPrayerTimeData(id);
      hesapla();
      _schedulePrayerNotifications();
    })();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => hesapla());
  }

  Future<void> hesapla() async {
    setState(
      () {
        now = new DateTime.now();
        for (var i = 0; i < prayerTime.length; i++) {
          fullPrayerTime.replaceRange(i, i + 1, [DateTime(now.year, now.month, now.day, fullPrayerTime[i].hour, fullPrayerTime[i].minute)]);
        }
        prevMoonTime = DateTime(now.year, now.month, now.day - 1, fullPrayerTime[5].hour, fullPrayerTime[5].minute);
        nextImsakTime = DateTime(now.year, now.month, now.day + 1, fullPrayerTime[6].hour, fullPrayerTime[6].minute);
        nextIftarTime = DateTime(now.year, now.month, now.day + 1, fullPrayerTime[7].hour, fullPrayerTime[7].minute);

        //Before
        bool imsakBefore = now.isBefore(fullPrayerTime[0]);
        bool sunBefore = now.isBefore(fullPrayerTime[1]);
        bool noonBefore = now.isBefore(fullPrayerTime[2]);
        bool afternoonBefore = now.isBefore(fullPrayerTime[3]);
        bool eveningBefore = now.isBefore(fullPrayerTime[4]);
        bool moonBefore = now.isBefore(fullPrayerTime[5]);

        //After
        bool imsakAfter = now.isAfter(fullPrayerTime[0]);
        bool sunAfter = now.isAfter(fullPrayerTime[1]);
        bool noonAfter = now.isAfter(fullPrayerTime[2]);
        bool afternoonAfter = now.isAfter(fullPrayerTime[3]);
        bool eveningAfter = now.isAfter(fullPrayerTime[4]);
        bool moonAfter = now.isAfter(fullPrayerTime[5]);

        bool prevMoonAfter = now.isAfter(prevMoonTime);
        bool nextImsakBefore = now.isBefore(nextImsakTime);
        bool nextIftarBefore = now.isBefore(nextIftarTime);

        if (imsakBefore && prevMoonAfter == true) {
          nextPrayerTime = fullPrayerTime[0];
          nextPrayer = LocaleKeys.imsak.tr();
        } else if (sunBefore && imsakAfter == true) {
          nextPrayerTime = fullPrayerTime[1];
          nextPrayer = LocaleKeys.sun.tr();
        } else if (noonBefore && sunAfter == true) {
          nextPrayerTime = fullPrayerTime[2];
          nextPrayer = LocaleKeys.noon.tr();
        } else if (afternoonBefore && noonAfter == true) {
          nextPrayerTime = fullPrayerTime[3];
          nextPrayer = LocaleKeys.afternoon.tr();
        } else if (eveningBefore && afternoonAfter == true) {
          nextPrayerTime = fullPrayerTime[4];
          nextPrayer = LocaleKeys.evening.tr();
        } else if (moonBefore && eveningAfter == true) {
          nextPrayerTime = fullPrayerTime[5];
          nextPrayer = LocaleKeys.moon.tr();
        } else if (nextImsakBefore && moonAfter == true) {
          nextPrayerTime = nextImsakTime;
          nextPrayer = LocaleKeys.imsak.tr();
        } else {
          print("null from the if statment");
          return null;
        }
        iftarTime = nextIftarBefore && eveningAfter == true ? nextIftarTime : fullPrayerTime[4];

        differenceInHoursIftar = ((iftarTime.difference(now).inHours) % 24);
        differenceInMinutesIftar = ((iftarTime.difference(now).inMinutes) % 60);
        differenceInSecIftar = ((iftarTime.difference(now).inSeconds) % 60);

        differenceInHoursPrayer = ((nextPrayerTime.difference(now).inHours) % 24);
        differenceInMinutesPrayer = ((nextPrayerTime.difference(now).inMinutes) % 60);
        differenceInSecPrayer = ((nextPrayerTime.difference(now).inSeconds) % 60);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEEE dd MMMM yyyy', LocaleKeys.locale.tr());
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: prayerResult.isEmpty
          ? buildLoadingIndicator(context)
          : ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 10, 32, 10), //22, 17, 32, 17
                  child: Column(
                    children: <Widget>[
                      TimeContainer(time: format.format(now)),
                      Helper.sizedBoxH10,
                      NextPrayerTimeContainer(
                          hour: differenceInHoursPrayer, minute: differenceInMinutesPrayer, second: differenceInSecPrayer, nextPrayer: nextPrayer),
                      Helper.sizedBoxH10,
                      IftarTimeContanier(hour: differenceInHoursIftar, minute: differenceInMinutesIftar, second: differenceInSecIftar),
                      Helper.sizedBoxH10,
                      PrayerTimeContainer(prayerTime: prayerTime, districtName: districtName),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget buildLoadingIndicator(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple, color: Theme.of(context).primaryColor),
      ),
    );
  }

  Future<String> getPref(String key, String defaultValue) async {
    prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? defaultValue;
    return value;
  }
}

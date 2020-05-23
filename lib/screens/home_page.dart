import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prayertimes/models/result.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart';
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;
import 'package:prayertimes/ui/widgets/app_bar.dart' show CustomAppBar;
import 'package:prayertimes/ui/widgets/bottomBarWidgets/bottom_bar.dart' show CustomBottomNavigationBar;
import 'package:prayertimes/ui/widgets/homePageWidgets/iftarTimeContainer.dart' show IftarTimeContanier;
import 'package:prayertimes/ui/widgets/homePageWidgets/prayerTimeContainer.dart' show PrayerTimeContainer;
import 'package:prayertimes/ui/widgets/homePageWidgets/timeContainer.dart' show TimeContainer;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final format = new DateFormat('EEEE dd MMMM yyyy', 'tr_TR');
  final formatTime = new DateFormat('HH:mm');
  Timer timer;
  bool visibleRamazan = true;
  String differenceInDays = "";
  String differenceInHours, differenceInMinutes, differenceInSec;
  var now, eveningTime;

  List<PrayerTime> prayerResult = [];
  List<String> prayerTime = [];

  Future<void> _getPrayerTimeData() async {
    List<PrayerTime> _prayerTemp = await getPrayerTimeData(AppConstants.districtID);
    setState(() {
      prayerResult = _prayerTemp;
      prayerTime.add(prayerResult[0].imsak);
      prayerTime.add(prayerResult[0].gunes);
      prayerTime.add(prayerResult[0].ogle);
      prayerTime.add(prayerResult[0].ikindi);
      prayerTime.add(prayerResult[0].aksam);
      prayerTime.add(prayerResult[0].yatsi);
      eveningTime = formatTime.parse(prayerResult[0].aksam);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getPrayerTimeData();
      ramazanFunc();
    });
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => hesapla());
  }

  Future<void> hesapla() async {
    setState(() {
      final now = DateTime.now();
      differenceInHours = ((eveningTime.difference(now).inHours) % 24).toString();
      differenceInMinutes = ((eveningTime.difference(now).inMinutes) % 60).toString();
      differenceInSec = ((eveningTime.difference(now).inSeconds) % 60).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.fromLTRB(22, 17, 32, 17),
                  child: Column(
                    children: <Widget>[
                      TimeContainer(ramazanDay: differenceInDays, time: format.format(now).toString(), visibleRamazan: visibleRamazan),
                      Helper.sizedBoxH20,
                      IftarTimeContanier(hour: differenceInHours, minute: differenceInMinutes, second: differenceInSec),
                      Helper.sizedBoxH20,
                      PrayerTimeContainer(city: "City", prayerTime: prayerTime),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Center buildLoadingIndicator(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple, color: Theme.of(context).primaryColor),
      ),
    );
  }

  void ramazanFunc() {
    now = new DateTime.now();
    var ramazanStarting = new DateTime.utc(2020, 4, 24);
    differenceInDays = (now.difference(ramazanStarting).inDays).toString();
    (now.difference(ramazanStarting).inDays) == 30 ? visibleRamazan = false : visibleRamazan = true;
  }
}

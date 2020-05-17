import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:prayertimes/ui/widgets/app_bar.dart' show CustomAppBar;
import 'package:prayertimes/ui/widgets/bottom_bar.dart' show CustomBottomNavigationBar;
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;
import 'package:prayertimes/ui/widgets/homePageWidgets/iftarTimeContainer.dart' show IftarTimeContanier;
import 'package:prayertimes/ui/widgets/homePageWidgets/prayerTimeContainer.dart' show PrayerTimeContainer;
import 'package:prayertimes/ui/widgets/homePageWidgets/timeContainer.dart' show TimeContainer;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var now;
  final format = new DateFormat('EEEE dd MMMM yyyy', 'tr_TR');
  bool visibleRamazan = true;
  String differenceInDays = "";

  @override
  void initState() {
    super.initState();
    setState(() => ramazanFunc());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 32, 32, 22),
          child: Column(
            children: <Widget>[
              TimeContainer(ramazanDay: differenceInDays, time: format.format(now).toString(), visibleRamazan: visibleRamazan),
              Helper.sizedBoxH20,
              IftarTimeContanier(hour: 3, minute: 35, second: 33),
              Helper.sizedBoxH20,
              PrayerTimeContainer(city: "Bursa"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  void ramazanFunc() {
    now = new DateTime.now();
    var ramazanStarting = new DateTime.utc(2020, 4, 24);
    differenceInDays = (now.difference(ramazanStarting).inDays).toString();
    (now.difference(ramazanStarting).inDays) == 30 ? visibleRamazan = false : visibleRamazan = true;
  }
}

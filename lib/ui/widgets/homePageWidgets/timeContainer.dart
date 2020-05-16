import 'package:flutter/material.dart';
import 'package:prayertimes/ui/helper/AppStrings.dart' show AppStrings;
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;

class TimeContainer extends StatelessWidget {
  final String time;
  final bool visibleRamazan;
  final String ramazanDay;
  const TimeContainer({Key key, @required this.time, @required this.visibleRamazan, @required this.ramazanDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: Helper.buildBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(time, style: Theme.of(context).textTheme.headline6),
            Helper.sizedBoxH10,
            Visibility(visible: visibleRamazan, child: Text(AppStrings.ramazan + " " + ramazanDay, style: Theme.of(context).textTheme.headline6))
          ],
        ),
      ),
    );
  }
}

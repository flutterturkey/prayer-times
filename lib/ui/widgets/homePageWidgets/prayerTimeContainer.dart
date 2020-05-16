import 'package:flutter/material.dart';
import 'package:prayertimes/ui/helper/AppIcons.dart' show AppIcons;
import 'package:prayertimes/ui/helper/AppStrings.dart' show AppStrings;

import '../helper.dart';

class PrayerTimeContainer extends StatelessWidget {
  final String city;
  const PrayerTimeContainer({Key key, @required this.city}) : super(key: key);

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
            Text("$city " + AppStrings.prayerTime, style: Theme.of(context).textTheme.headline6),
            Helper.sizedBoxH10,
            Table(
              children: <TableRow>[
                buildTableRow(context, AppIcons.imsak, AppStrings.imsak),
                buildTableRow(context, AppIcons.sun, AppStrings.sun),
                buildTableRow(context, AppIcons.noon, AppStrings.noon),
                buildTableRow(context, AppIcons.afternoon, AppStrings.afternoon),
                buildTableRow(context, AppIcons.evening, AppStrings.evening),
                buildTableRow(context, Icon(AppIcons.moon, size: 17), AppStrings.moon),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(BuildContext context, Widget _icon, String _time) {
    return TableRow(children: [
      TableCell(child: _icon, verticalAlignment: TableCellVerticalAlignment.middle),
      TableCell(
        child: Text(_time, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle2),
        verticalAlignment: TableCellVerticalAlignment.middle,
      ),
      TableCell(
          child: Text("Vakit", textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle2),
          verticalAlignment: TableCellVerticalAlignment.middle),
    ]);
  }
}

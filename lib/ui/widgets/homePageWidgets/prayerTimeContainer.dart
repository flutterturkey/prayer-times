import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      decoration: Helper.buildBoxDecoration(context),
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
                buildTableRow(context, imsak(Theme.of(context).iconTheme.color), AppStrings.imsak),
                buildTableRow(context, sun(Theme.of(context).iconTheme.color), AppStrings.sun),
                buildTableRow(context, noon(Theme.of(context).iconTheme.color), AppStrings.noon),
                buildTableRow(context, afternoon(Theme.of(context).iconTheme.color), AppStrings.afternoon),
                buildTableRow(context, evening(Theme.of(context).iconTheme.color), AppStrings.evening),
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

  SvgPicture imsak(Color color) => SvgPicture.asset(AppIcons.imsakSVG, color: color, height: 17);
  SvgPicture sun(Color color) => SvgPicture.asset(AppIcons.sunSVG, color: color, height: 17);
  SvgPicture noon(Color color) => SvgPicture.asset(AppIcons.noonSVG, color: color, height: 17);
  SvgPicture afternoon(Color color) => SvgPicture.asset(AppIcons.afternoonSVG, color: color, height: 17);
  SvgPicture evening(Color color) => SvgPicture.asset(AppIcons.eveningSVG, color: color, height: 17);
}

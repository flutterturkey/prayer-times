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
    var iconColor = Theme.of(context).iconTheme.color;
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
              defaultColumnWidth: FractionColumnWidth(.30),
              children: <TableRow>[
                buildTableRow(context, tableWidget(context, imsak(iconColor)), AppStrings.imsak),
                buildTableRow(context, tableWidget(context, sun(iconColor)), AppStrings.sun),
                buildTableRow(context, tableWidget(context, noon(iconColor)), AppStrings.noon),
                buildTableRow(context, tableWidget(context, afternoon(iconColor)), AppStrings.afternoon),
                buildTableRow(context, tableWidget(context, evening(iconColor)), AppStrings.evening),
                buildTableRow(context, tableWidget(context, Icon(AppIcons.moon, size: 17)), AppStrings.moon),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(BuildContext context, Widget _icon, String _time) {
    return TableRow(
      children: [
        TableCell(child: _icon, verticalAlignment: TableCellVerticalAlignment.middle),
        TableCell(child: Text(_time, textAlign: TextAlign.center, style: _buildTableTextStyle(context)), verticalAlignment: TableCellVerticalAlignment.middle),
        TableCell(child: Text("NULL", textAlign: TextAlign.center, style: _buildTableTextStyle(context)), verticalAlignment: TableCellVerticalAlignment.middle),
      ],
    );
  }

  Container tableWidget(BuildContext context, Widget _widget) => Container(
        height: MediaQuery.of(context).size.height / 20,
        child: _widget,
      );

  SvgPicture imsak(Color color) => SvgPicture.asset(AppIcons.imsakSVG, color: color, height: 17);
  SvgPicture sun(Color color) => SvgPicture.asset(AppIcons.sunSVG, color: color, height: 17);
  SvgPicture noon(Color color) => SvgPicture.asset(AppIcons.noonSVG, color: color, height: 17);
  SvgPicture afternoon(Color color) => SvgPicture.asset(AppIcons.afternoonSVG, color: color, height: 17);
  SvgPicture evening(Color color) => SvgPicture.asset(AppIcons.eveningSVG, color: color, height: 17);

  TextStyle _buildTableTextStyle(BuildContext context) => Theme.of(context).textTheme.subtitle2;
}

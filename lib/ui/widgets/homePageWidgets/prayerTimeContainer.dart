import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart';
import 'package:prayertimes/ui/helper/AppIcons.dart' show AppIcons;

import '../helper.dart';

class PrayerTimeContainer extends StatelessWidget {
  final List<String> prayerTime;
  final String districtName;
  const PrayerTimeContainer({
    Key key,
    @required this.prayerTime,
    @required this.districtName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).iconTheme.color;
    Locale myLocale = Localizations.localeOf(context);
    return Container(
      width: double.infinity,
      decoration: Helper.buildBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                myLocale == AppConstants.TR_LOCALE
                    ? districtName + " " + LocaleKeys.prayerTime.tr()
                    : LocaleKeys.prayerTime.tr() + " " + districtName,
                style: Theme.of(context).textTheme.headline6),
            Helper.sizedBoxH10,
            Table(
              defaultColumnWidth: FractionColumnWidth(.30),
              children: <TableRow>[
                buildTableRow(context, tableWidget(context, imsak(iconColor)),
                    LocaleKeys.imsak.tr(), prayerTime[0]),
                buildTableRow(context, tableWidget(context, sun(iconColor)),
                    LocaleKeys.sun.tr(), prayerTime[1]),
                buildTableRow(context, tableWidget(context, noon(iconColor)),
                    LocaleKeys.noon.tr(), prayerTime[2]),
                buildTableRow(
                    context,
                    tableWidget(context, afternoon(iconColor)),
                    LocaleKeys.afternoon.tr(),
                    prayerTime[3]),
                buildTableRow(context, tableWidget(context, evening(iconColor)),
                    LocaleKeys.evening.tr(), prayerTime[4]),
                buildTableRow(
                    context,
                    tableWidget(context, Icon(AppIcons.moon, size: 17)),
                    LocaleKeys.moon.tr(),
                    prayerTime[5]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(
      BuildContext context, Widget _icon, String _timeName, String _time) {
    return TableRow(
      children: [
        TableCell(
            child: _icon, verticalAlignment: TableCellVerticalAlignment.middle),
        TableCell(
            child: Text(_timeName,
                textAlign: TextAlign.center,
                style: _buildTableTextStyle(context)),
            verticalAlignment: TableCellVerticalAlignment.middle),
        TableCell(
            child: Text(_time,
                textAlign: TextAlign.center,
                style: _buildTableTextStyle2(context)),
            verticalAlignment: TableCellVerticalAlignment.middle),
      ],
    );
  }

  Container tableWidget(BuildContext context, Widget _widget) => Container(
      height: MediaQuery.of(context).size.height / 20,
      child: Container(padding: EdgeInsets.all(7), child: _widget));

  SvgPicture imsak(Color color) =>
      SvgPicture.asset(AppIcons.imsakSVG, color: color, height: 17);
  SvgPicture sun(Color color) =>
      SvgPicture.asset(AppIcons.sunSVG, color: color, height: 17);
  SvgPicture noon(Color color) =>
      SvgPicture.asset(AppIcons.noonSVG, color: color, height: 17);
  SvgPicture afternoon(Color color) =>
      SvgPicture.asset(AppIcons.afternoonSVG, color: color, height: 17);
  SvgPicture evening(Color color) =>
      SvgPicture.asset(AppIcons.eveningSVG, color: color, height: 17);

  TextStyle _buildTableTextStyle2(BuildContext context) =>
      Theme.of(context).textTheme.subtitle1;
  TextStyle _buildTableTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.subtitle2;
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:prayertimes/ui/helper/AppIcons.dart';
import 'package:prayertimes/ui/styles/appBorderRadius.dart';
import 'package:easy_localization/easy_localization.dart';


class NotificationDailog extends StatelessWidget {
  final String payload;

  const NotificationDailog({Key key, @required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var payloadInt = int.parse(payload);
    List<String> prayer = List(5);
    prayer[0] = LocaleKeys.imsak.tr();
    prayer[1] = LocaleKeys.noon.tr();
    prayer[2] = LocaleKeys.afternoon.tr();
    prayer[3] = LocaleKeys.evening.tr();
    prayer[4] = LocaleKeys.moon.tr();
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: AppBorderRadius.alertDialogRadius,
      title: Center(
        child: Text(LocaleKeys.reminder.tr(),
            style: Theme.of(context).textTheme.headline6),
      ),
      content: Form(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  buildLoadingContainer(
                      150, Theme.of(context).dividerColor.withOpacity(0.14)),
                  buildLoadingContainer(
                      130, Theme.of(context).dividerColor.withOpacity(0.29)),
                  buildLoadingContainer(110, Theme.of(context).dividerColor),
                  Container(
                    child: _icon(Theme.of(context).cardColor, context),
                    height: 50,
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(prayer[payloadInt],
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text(LocaleKeys.cancel.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  SvgPicture imsak(Color color) =>
      SvgPicture.asset(AppIcons.imsakSVG, color: color, height: 50);
  SvgPicture sun(Color color) =>
      SvgPicture.asset(AppIcons.sunSVG, color: color, height: 50);
  SvgPicture noon(Color color) =>
      SvgPicture.asset(AppIcons.noonSVG, color: color, height: 50);
  SvgPicture afternoon(Color color) =>
      SvgPicture.asset(AppIcons.afternoonSVG, color: color, height: 50);
  SvgPicture evening(Color color) =>
      SvgPicture.asset(AppIcons.eveningSVG, color: color, height: 50);

  Widget _icon(Color color, BuildContext context) {
    switch (payload) {
      case "0":
        {
          return imsak(color);
        }

      case "1":
        {
          return noon(color);
        }

      case "2":
        {
          return afternoon(color);
        }

      case "3":
        {
          return evening(color);
        }
        default:
        {
          return Icon(AppIcons.moon, color: color, size: 50);
        }
    }
  }

  Container buildLoadingContainer(double _size, Color _color) => Container(
      height: _size,
      width: _size,
      decoration: _buildLoadingBoxDecoration(_color));

  BoxDecoration _buildLoadingBoxDecoration(Color _color) =>
      BoxDecoration(color: _color, shape: BoxShape.circle);
}

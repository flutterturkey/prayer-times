import 'package:flutter/material.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;

class IftarTimeContanier extends StatelessWidget {
  final int hour, minute, second;

  const IftarTimeContanier(
      {Key key,
      @required this.hour,
      @required this.minute,
      @required this.second})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: Helper.buildBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(LocaleKeys.timeToIftar.tr(),
                style: Theme.of(context).textTheme.headline6),
            Helper.sizedBoxH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildTimeSection(context, LocaleKeys.hour.plural(hour), hour),
                buildTimeSection(
                    context, LocaleKeys.minute.plural(minute), minute),
                buildTimeSection(
                    context, LocaleKeys.second.plural(second), second),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildTimeSection(BuildContext context, String subTitle, int time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("$time", style: Theme.of(context).textTheme.headline4),
        Text(subTitle, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

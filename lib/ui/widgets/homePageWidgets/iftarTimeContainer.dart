import 'package:flutter/material.dart'
    show BuildContext, Column, Container, CrossAxisAlignment, EdgeInsets, Key, MainAxisAlignment, Padding, Row, StatelessWidget, Text, Theme, Widget, required;
import 'package:prayertimes/ui/helper/AppStrings.dart' show AppStrings;
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;

class IftarTimeContanier extends StatelessWidget {
  final int hour, minute, second;

  const IftarTimeContanier({Key key, @required this.hour, @required this.minute, @required this.second}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: Helper.buildBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppStrings.timeToIftar, style: Theme.of(context).textTheme.headline6),
            Helper.sizedBoxH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildTimeSection(context, AppStrings.hour, hour),
                buildTimeSection(context, AppStrings.minute, minute),
                buildTimeSection(context, AppStrings.second, second),
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
        Text("$time", style: Theme.of(context).textTheme.headline3),
        Text(subTitle, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;

class TimeContainer extends StatelessWidget {
  final String time;
  const TimeContainer({Key key, @required this.time}) : super(key: key);

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
            Text(time, style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
    );
  }
}

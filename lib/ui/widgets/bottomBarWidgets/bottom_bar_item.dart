import 'package:flutter/material.dart';
import 'package:prayertimes/ui/styles/appBorderRadius.dart';
import 'package:prayertimes/ui/widgets/helper.dart';

class BottomBarItem extends StatefulWidget {
  final IconData iconData;
  final String title;
  final Function function;

  const BottomBarItem({
    Key key,
    @required this.iconData,
    @required this.title,
    @required this.function,
  }) : super(key: key);

  @override
  _BottomBarItemState createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem> {
  static const double size = 70;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppBorderRadius.onboardingBarRadius,
          onTap: () => widget.function(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.iconData),
              Helper.sizedBoxH5,
              Text(widget.title, style: Theme.of(context).textTheme.button)
            ],
          ),
        ),
      ),
    );
  }
}

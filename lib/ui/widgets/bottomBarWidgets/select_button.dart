import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:prayertimes/ui/styles/appBorderRadius.dart';

class SelectButton extends StatefulWidget {
  final String title;
  final bool onOff;
  final GestureTapCallback onPressed;

  const SelectButton({
    Key key,
    @required this.title,
    @required this.onOff,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: AppBorderRadius.onboardingBarRadius,
          child: Container(
            color: widget.onOff
                ? Theme.of(context).iconTheme.color.withOpacity(0.60)
                : Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              splashColor: widget.onOff
                  ? Theme.of(context).iconTheme.color.withOpacity(0.60)
                  : Colors.transparent,
              borderRadius: AppBorderRadius.onboardingBarRadius,
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: Theme.of(context).iconTheme.color.withOpacity(0.60),
                radius: AppBorderRadius.buttonRadius,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                  child: Center(
                    child: Text(widget.title,
                        style: Theme.of(context).textTheme.button),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
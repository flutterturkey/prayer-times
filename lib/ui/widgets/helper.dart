import 'package:flutter/material.dart' show BoxDecoration, Colors, SizedBox;
import 'package:prayertimes/ui/styles/appBorderRadius.dart' show AppBorderRadius;
import 'package:prayertimes/ui/styles/appBoxShadow.dart' show AppBoxShadow;

class Helper {
  static SizedBox get sizedBoxH5 => SizedBox(height: 5);
  static SizedBox get sizedBoxH10 => SizedBox(height: 10);
  static SizedBox get sizedBoxH20 => SizedBox(height: 20);
  static SizedBox get sizedBoxH30 => SizedBox(height: 30);
  static SizedBox get sizedBoxH50 => SizedBox(height: 50);
  static SizedBox get sizedBoxH80 => SizedBox(height: 80);
  static SizedBox get sizedBoxH100 => SizedBox(height: 100);
  static SizedBox get sizedBoxW10 => SizedBox(width: 10);
  static SizedBox get sizedBoxW20 => SizedBox(width: 20);

  static BoxDecoration get buildBoxDecoration =>
      BoxDecoration(color: Colors.white, borderRadius: AppBorderRadius.timeContainerRadius, boxShadow: [AppBoxShadow.containerBoxShadow]);

  static BoxDecoration get buildOnboardingBoxDecoration =>
      BoxDecoration(color: Colors.white, borderRadius: AppBorderRadius.timeContainerRadius, boxShadow: [AppBoxShadow.containerBoxShadow]);
}

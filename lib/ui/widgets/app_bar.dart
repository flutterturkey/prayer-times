import 'package:flutter/material.dart';
import 'package:prayertimes/ui/helper/AppStrings.dart' show AppStrings;
import 'package:prayertimes/ui/styles/appBorderRadius.dart' show AppBorderRadius;
import 'package:prayertimes/ui/styles/appBoxShadow.dart' show AppBoxShadow;
import 'package:prayertimes/ui/styles/appTextStyles.dart' show AppTextStyles;

import 'appLogo.dart' show AppLogo;
import 'helper.dart' show Helper;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.0),
      child: Container(
        decoration: _buildBoxDecoration,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppLogo(color: Theme.of(context).primaryColor, height: 30),
                Helper.sizedBoxW20,
                Text(AppStrings.appName, style: AppTextStyles.appBarTextStyles),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration =>
      BoxDecoration(color: Colors.white, borderRadius: AppBorderRadius.appBarRadius, boxShadow: [AppBoxShadow.materialShadow]);

  @override
  Size get preferredSize => Size.fromHeight(90.0);
}

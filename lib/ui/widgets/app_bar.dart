import 'package:flutter/material.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:prayertimes/ui/styles/appBorderRadius.dart' show AppBorderRadius;
import 'package:prayertimes/ui/styles/appBoxShadow.dart' show AppBoxShadow;
import 'package:easy_localization/easy_localization.dart';

import 'appLogo.dart' show AppLogo;
import 'helper.dart' show Helper;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.0),
      child: Container(
        decoration: _buildBoxDecoration(context),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppLogo(color: Theme.of(context).iconTheme.color, height: 30),
                Helper.sizedBoxW20,
                Text(LocaleKeys.appName.tr(), style: Theme.of(context).textTheme.headline4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) =>
      BoxDecoration(color: Theme.of(context).cardColor, borderRadius: AppBorderRadius.appBarRadius, boxShadow: [AppBoxShadow.materialShadow]);

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}

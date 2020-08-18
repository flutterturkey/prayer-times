import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart' show TextFieldConfiguration, TypeAheadFormField;
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prayertimes/models/city.dart';
import 'package:prayertimes/models/country.dart';
import 'package:prayertimes/models/custom_theme_mode.dart' show CustomThemeMode;
import 'package:prayertimes/models/district.dart';
import 'package:prayertimes/screens/home_page.dart';
import 'package:prayertimes/ui/helper/AppConstants.dart';
import 'package:prayertimes/ui/widgets/bottomBarWidgets/select_button.dart';
import 'package:prayertimes/ui/widgets/helper.dart' show Helper;
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:prayertimes/models/result.dart';
import 'package:prayertimes/ui/helper/AppIcons.dart' show AppIcons;
import 'package:prayertimes/ui/styles/appBorderRadius.dart' show AppBorderRadius;
import 'package:prayertimes/ui/styles/appBoxShadow.dart' show AppBoxShadow;

import '../../../main.dart';
import '../../helper/local_notifications_helper.dart';
import 'bottom_bar_item.dart';

Future<bool> getAllowsNotifications() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool(AppConstants.keyNotifications) ?? true;
}

Future<bool> setAllowNotifications(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.setBool(AppConstants.keyNotifications, value);
}

Future<bool> getAllowSound() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool(AppConstants.keyNotificationSound) ?? true;
}

Future<bool> setAllowSound(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.setBool(AppConstants.keyNotificationSound, value);
}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final TextEditingController countryTextController = TextEditingController();
  final TextEditingController cityTextController = TextEditingController();
  final TextEditingController districtTextController = TextEditingController();
  SharedPreferences prefs;

  String selectedCountry, selectedCountryId, selectedCity, selectedCityId, selectedDistrict, selectedDistrictId = "";

  List<Country> countryResult = [];
  List<City> cityResult = [];
  List<District> districtResult = [];

  @override
  void initState() {
    super.initState();
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject(context);
    getAllowsNotifications();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration,
      child: ClipRRect(
        borderRadius: AppBorderRadius.bottomBarRadius,
        child: Container(
          height: 80,
          decoration: _buildBoxDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarItem(iconData: AppIcons.location, title: LocaleKeys.location.tr(), function: showSelectCountry),
              BottomBarItem(iconData: AppIcons.home, title: LocaleKeys.homePage.tr(), function: doAnything),
              BottomBarItem(iconData: AppIcons.settings, title: LocaleKeys.settings.tr(), function: showSettings),
            ],
          ),
        ),
      ),
    );
  }

  doAnything() {
    return checkPendingNotificationRequests(context, flutterLocalNotificationsPlugin);
  }

  void showSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BuildNotificationButton();
      },
    );
  }

  void showSelectCountry() {
    print(MediaQuery.of(context).size.height * 0.33);
    clearTextEditing();
    if (cityResult.isEmpty) _getCountryData();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: AppBorderRadius.alertDialogRadius,
            title: Text(LocaleKeys.changeLocation.tr(), style: Theme.of(context).textTheme.headline6),
            content: Form(
              child: Container(
                height: 280, // MediaQuery.of(context).size.height * 0.33
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  children: <Widget>[
                    TypeAheadFormField(
                      getImmediateSuggestions: true,
                      itemBuilder: (context, suggestion) => Card(child: ListTile(title: Text(suggestion))),
                      onSuggestionSelected: (suggestion) => onCountrySuggestionSelected(suggestion),
                      suggestionsCallback: (pattern) => getCountrySuggestions(pattern),
                      errorBuilder: (context, Object error) => Text(LocaleKeys.errorCity.tr()),
                      noItemsFoundBuilder: (context) => buildNoItemsBuilder(context, LocaleKeys.country.tr()),
                      textFieldConfiguration: buildTextFieldConfiguration(context, this.countryTextController, LocaleKeys.chooseCountry.tr()),
                      onSaved: (value) => onCountrySuggestionSelected(value),
                    ),
                    Helper.sizedBoxH10,
                    TypeAheadFormField(
                      getImmediateSuggestions: true,
                      itemBuilder: (context, suggestion) => Card(child: ListTile(title: Text(suggestion))),
                      onSuggestionSelected: (suggestion) => onCitySuggestionSelected(suggestion),
                      suggestionsCallback: (pattern) => getCitySuggestions(pattern),
                      errorBuilder: (context, Object error) => Text(LocaleKeys.errorCity.tr()),
                      noItemsFoundBuilder: (context) => buildNoItemsBuilder(context, LocaleKeys.city.tr()),
                      textFieldConfiguration: buildTextFieldConfiguration(context, this.cityTextController, LocaleKeys.chooseCity.tr()),
                      onSaved: (value) => onCitySuggestionSelected(value),
                    ),
                    Helper.sizedBoxH10,
                    TypeAheadFormField(
                      getImmediateSuggestions: true,
                      itemBuilder: (context, suggestion) => Card(child: ListTile(title: Text(suggestion))),
                      onSuggestionSelected: (suggestion) => onDistrictSuggestionSelected(suggestion),
                      suggestionsCallback: (pattern) => getDistrictSuggestions(pattern),
                      errorBuilder: (context, Object error) => Text(LocaleKeys.errorCity.tr()),
                      noItemsFoundBuilder: (context) => buildNoItemsBuilder(context, LocaleKeys.district.tr()),
                      textFieldConfiguration: buildTextFieldConfiguration(context, this.districtTextController, LocaleKeys.chooseDistrict.tr()),
                      onSaved: (value) => this.selectedDistrict = value,
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(shape: AppBorderRadius.alertDialogRadius, child: Text(LocaleKeys.cancel.tr()), onPressed: () => clickCancelBtn()),
                        Helper.sizedBoxW10,
                        FlatButton(
                          color: Theme.of(context).iconTheme.color.withOpacity(0.60),
                          shape: AppBorderRadius.alertDialogRadius,
                          child: Text(LocaleKeys.add.tr()),
                          onPressed: () => clickAddBtn(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void onCountrySuggestionSelected(String suggestion) {
    this.countryTextController.text = suggestion;
    this.selectedCountry = suggestion;
    try {
      countryResult.asMap().forEach((index, element) {
        if ((element.countryName) == suggestion) {
          _getCityData(element.countryID);
          selectedCountryId = element.countryID;
        }
      });
    } catch (e) {
      print(e.error);
    }
  }

  void onCitySuggestionSelected(String suggestion) {
    this.cityTextController.text = suggestion;
    this.selectedCity = suggestion;
    try {
      cityResult.asMap().forEach((index, element) {
        if ((element.cityName) == suggestion) {
          _getDistrictData(element.cityID);
          selectedCityId = element.cityID;
        }
      });
    } catch (e) {
      print(e.error);
    }
  }

  void onDistrictSuggestionSelected(String suggestion) {
    this.districtTextController.text = suggestion;
    this.selectedDistrict = suggestion;
    try {
      districtResult.asMap().forEach((index, element) {
        if ((element.districtName) == suggestion) selectedDistrictId = element.districtID;
      });
    } catch (e) {
      print(e.error);
    }
  }

  void _getCountryData() async {
    List<Country> _countryTemp = await getCountryData();
    setState(() {
      countryResult = _countryTemp;
      print("Country Data alındı.");
    });
  }

  void _getCityData(String _selectedCountryId) async {
    List<City> _cityTemp = await getCityData(_selectedCountryId);
    setState(() {
      cityResult = _cityTemp;
      print("City Data alındı.");
    });
  }

  void _getDistrictData(String _selectedCityId) async {
    List<District> _districtTemp = await getDistrictData(_selectedCityId);
    setState(() {
      districtResult = _districtTemp;
      print("District Data alındı.");
    });
  }

  List<String> getCountrySuggestions(String query) {
    List<String> countries = List();
    countryResult.forEach((element) {
      countries.add(element.countryName);
    });
    countries.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return countries;
  }

  List<String> getCitySuggestions(String query) {
    List<String> cities = List();
    cityResult.forEach((element) {
      cities.add(element.cityName);
    });
    cities.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return cities;
  }

  List<String> getDistrictSuggestions(String query) {
    List<String> districts = List();
    districtResult.forEach((element) {
      districts.add(element.districtName);
    });
    districts.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    return districts;
  }

  void clearTextEditing() {
    countryTextController.text = "";
    cityTextController.text = "";
    districtTextController.text = "";
  }

  void clickCancelBtn() {
    clearTextEditing();
    Navigator.pop(context, true);
  }

  Future<void> clickAddBtn() async {
    if (selectedDistrictId == '') {
      Navigator.pop(context, true);
    } else {
      setState(() {
        setPref(AppConstants.keyCountryId, selectedCountryId);
        setPref(AppConstants.keyCityId, selectedCityId);
        setPref(AppConstants.keyDistrictId, selectedDistrictId);

        setPref(AppConstants.keyCountry, selectedCountry);
        setPref(AppConstants.keyCity, selectedCity);
        setPref(AppConstants.keyDistrict, selectedDistrict);
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  TextFieldConfiguration buildTextFieldConfiguration(BuildContext context, TextEditingController _typeAheadController, String _hintText) {
    return TextFieldConfiguration(
      onTap: () => _typeAheadController.text = "",
      controller: _typeAheadController,
      cursorColor: Theme.of(context).primaryColorLight,
      autocorrect: true,
      decoration: InputDecoration(
        suffixIcon: Icon(AppIcons.dropdown),
        filled: true,
        fillColor: Theme.of(context).accentColor,
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: AppBorderRadius.textEditingBorderRadius),
        hintText: _hintText,
        hintStyle: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Padding buildNoItemsBuilder(BuildContext context, String itemTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(itemTitle.contains('ا') ? LocaleKeys.notFound.tr() + " " + itemTitle : itemTitle + " " + LocaleKeys.notFound.tr(),
          textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).disabledColor, fontSize: 18.0)),
    );
  }

  BoxDecoration get _buildBoxDecoration =>
      BoxDecoration(color: Theme.of(context).cardColor, borderRadius: AppBorderRadius.bottomBarRadius, boxShadow: [AppBoxShadow.materialShadow]);

  Future<bool> setPref(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}

class BuildNotificationButton extends StatefulWidget {
  @override
  _BuildNotificationButtonState createState() => _BuildNotificationButtonState();
}

class _BuildNotificationButtonState extends State<BuildNotificationButton> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: AppBorderRadius.alertDialogRadius,
      title: Text(LocaleKeys.settings.tr(), style: Theme.of(context).textTheme.headline6),
      content: Form(
        child: Container(
          height: 383, // MediaQuery.of(context).size.height * 0.45
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.chooseTheme.tr()),
              Helper.sizedBoxH10,
              _buildThemeButton,
              Helper.sizedBoxH20,
              Text(LocaleKeys.chooseLanguage.tr()),
              Helper.sizedBoxH10,
              _buildLanguageButton,
              Helper.sizedBoxH20,
              _buildNotificationButton,
              Helper.sizedBoxH20,
              _buildSoundButton,
              Helper.sizedBoxH20,
              Align(alignment: Alignment.bottomRight, child: buildDoneButton),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton get buildDoneButton {
    return FlatButton(
      color: Theme.of(context).iconTheme.color.withOpacity(0.60),
      shape: AppBorderRadius.alertDialogRadius,
      child: Text(LocaleKeys.done.tr()),
      onPressed: () => clickDoneBtn(),
    );
  }

  void clickDoneBtn() {
    Navigator.pop(context, true);
  }

  Expanded get _buildThemeButton {
    ThemeMode currentTheme = Provider.of<CustomThemeMode>(context).getThemeMode;
    Map<String, bool> theme = {
      LocaleKeys.lightMode.tr(): currentTheme == ThemeMode.light ? true : false,
      LocaleKeys.darkMode.tr(): currentTheme == ThemeMode.dark ? true : false,
      LocaleKeys.systemMode.tr(): currentTheme == ThemeMode.system ? true : false
    };
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * .092,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: theme.length,
          itemBuilder: (BuildContext context, int index) {
            return SelectButton(
              title: theme.keys.toList()[index],
              onOff: theme.values.toList()[index],
              onPressed: () => setState(() {
                theme.forEach((key, value) {
                  theme[key] = key == theme.keys.toList()[index] ? true : false;
                  (theme.values.toList()[0] == true) ? selectLightMode() : (theme.values.toList()[1] == true) ? selectDarkMode() : selectSystemThemeMode();
                });
              }),
            );
          },
        ),
      ),
    );
  }

  Expanded get _buildLanguageButton {
    Locale myLocale = Localizations.localeOf(context);
    Map<String, bool> language = {
      LocaleKeys.turkish.tr(): myLocale == AppConstants.TR_LOCALE ? true : false,
      LocaleKeys.english.tr(): myLocale == AppConstants.EN_LOCALE ? true : false,
      LocaleKeys.arabic.tr(): myLocale == AppConstants.AR_LOCALE ? true : false
    };
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * .092,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: language.length,
          itemBuilder: (BuildContext context, int index) {
            return SelectButton(
              title: language.keys.toList()[index],
              onOff: language.values.toList()[index],
              onPressed: () => setState(() {
                language.forEach((key, value) {
                  language[key] = key == language.keys.toList()[index] ? true : false;
                  (language.values.toList()[0] == true) ? turkish() : (language.values.toList()[1] == true) ? english() : arabic();
                });
              }),
            );
          },
        ),
      ),
    );
  }

  Expanded get _buildNotificationButton {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .092,
        child: Row(
          children: <Widget>[
            Text(LocaleKeys.notifications.tr()),
            Expanded(child: SizedBox()),
            FutureBuilder<bool>(
              future: getAllowsNotifications(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.hasData
                    ? CupertinoSwitch(
                        value: snapshot.data,
                        onChanged: (bool value) {
                          setState(() {
                            setAllowNotifications(value);
                            if (value == true) {
                              showNotificationData(flutterLocalNotificationsPlugin, 5, "Notifications are on now!",
                                  "You will get notification for every prayer at it's time", "5");
                              schedulePrayerNotifications(flutterLocalNotificationsPlugin, fullPrayerTime);
                            } else {
                              setAllowSound(value);
                              turnOffNotifications(flutterLocalNotificationsPlugin);
                            }
                          });
                        },
                        activeColor: Theme.of(context).iconTheme.color.withOpacity(0.60),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded get _buildSoundButton {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .092,
        child: Row(
          children: <Widget>[
            Text(LocaleKeys.azan.tr()),
            Expanded(child: SizedBox()),
            FutureBuilder<bool>(
              future: getAllowSound(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.hasData
                    ? CupertinoSwitch(
                        value: snapshot.data,
                        onChanged: (bool value) {
                          setState(() {
                            setAllowSound(value);
                            if (value == true) {
                              setAllowNotifications(value);
                              showNotificationData(flutterLocalNotificationsPlugin, 5, "Notifications and ezan are on now!",
                                  "You will receive a notification at prayer times.", "5");
                              schedulePrayerNotificationsWithSound(flutterLocalNotificationsPlugin, fullPrayerTime);
                            } else {
                              schedulePrayerNotifications(flutterLocalNotificationsPlugin, fullPrayerTime);
                            }
                          });
                        },
                        activeColor: Theme.of(context).iconTheme.color.withOpacity(0.60),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void selectLightMode() => Provider.of<CustomThemeMode>(context).setThemeMode(ThemeMode.light);
  void selectDarkMode() => Provider.of<CustomThemeMode>(context).setThemeMode(ThemeMode.dark);
  void selectSystemThemeMode() => Provider.of<CustomThemeMode>(context).setThemeMode(ThemeMode.system);

  void turkish() => context.locale = AppConstants.TR_LOCALE;
  void english() => context.locale = AppConstants.EN_LOCALE;
  void arabic() => context.locale = AppConstants.AR_LOCALE;
}

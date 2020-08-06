import 'package:flutter/material.dart';
import 'package:prayertimes/ui/widgets/appLogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'onboarding_page.dart';

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  SharedPreferences sharedPreferences;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> getLocalData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isDone = sharedPreferences.getBool("oneTime");
      if (_isDone == null) _isDone = false;
      _isDone ? _pushHome() : _pushOnboarding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
              child:
                  AppLogo(color: Theme.of(context).splashColor, height: 100))),
    );
  }

  void _pushHome() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomePage()));
  void _pushOnboarding() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => OnboardingPage()));
}

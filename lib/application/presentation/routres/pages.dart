import 'package:abbon_mobile_test/application/presentation/pages/contact/main.dart';
import 'package:abbon_mobile_test/application/presentation/pages/home/main.dart';
import 'package:abbon_mobile_test/application/presentation/pages/main.dart';
import 'package:abbon_mobile_test/application/presentation/pages/setting/main.dart';
import 'package:abbon_mobile_test/application/presentation/pages/splash.dart';
import 'package:abbon_mobile_test/application/presentation/routres/name.dart';
import 'package:flutter/material.dart';

class RoutePages {
  static const root = Scaffold();
  static const main = MainPage();
  static const splash = SplashPage();
  static const home = HomePage();
  static const setting = SettingPage();
  static const contact = ContactPage();

  static Map<String, Widget Function(BuildContext)> routesPageAll = {
    RouteName.splash: (_) => RoutePages.splash,
    RouteName.main: (_) => RoutePages.main,
    RouteName.home: (_) => RoutePages.home,
    RouteName.setting: (_) => RoutePages.setting,
    RouteName.contact: (_) => RoutePages.contact,
  };
}

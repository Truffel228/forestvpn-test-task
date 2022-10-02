import 'package:flutter/material.dart';
import 'package:forestvpn_test/features/detailed_screen/detailed_screen.dart';
import 'package:forestvpn_test/features/main_screen/main_screen.dart';

abstract class Routes {
  static const String mainScreen = '/mainScreen';
  static const String deatailedScreen = '/detailedScreen';

  static Map<String, WidgetBuilder> getRoutes() => {
        mainScreen: (context) => const MainScreen(),
        deatailedScreen: (context) => const DetailedScreen(),
      };
}

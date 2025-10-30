import 'package:flutter/material.dart';
import 'package:your_sales/core/responsive/responsive_config.dart';

int mainLayoutIntitalScreenIndex = 0;
String? userToken;
final navigatorKey = GlobalKey<NavigatorState>();
const kPrimaryFont = 'IBMPlexSansArabic';
const kSecondryFont = 'Almarai';
final double kRadus = 8.r;
const LinearGradient appGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF2977BC), // #2977BC
    Color(0xFF2767B1), // #2767B1
  ],
  stops: [0.0, 1.0],
);

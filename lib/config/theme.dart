import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color travelokaBlue = Color(0xFF0064D2);
const Color travelokaLightGray = Color(0xFFF8F9FA);
const Color travelokaPriceRed = Color(0xFFFF5252);
const Color travelokaMediumGray = Color(0xFF6C757D);

final ThemeData appTheme = ThemeData(
  primaryColor: travelokaBlue,
  scaffoldBackgroundColor: travelokaLightGray,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.fromSeed(
    seedColor: travelokaBlue,
    primary: travelokaBlue,
    secondary: travelokaBlue,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.5,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);

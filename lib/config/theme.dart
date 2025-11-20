import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color klookOrange = Color(0xFFFF5B00);
const Color klookOrangeDark = Color(0xFFD94100);
const Color klookBackground = Color(0xFFF5F6F8);
const Color klookBlack = Color(0xFF1C1C1C);
const Color klookGray = Color(0xFF888888);
const Color klookSoftGray = Color(0xFFE0E0E0);

const LinearGradient klookGradient = LinearGradient(
  colors: [Color(0xFFFF5B00), Color(0xFFFF3366)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',

  colorScheme: ColorScheme.fromSeed(
    seedColor: klookOrange,
    primary: klookOrange,
    onPrimary: Colors.white,
    secondary: const Color(0xFFFF3366),
    surface: Colors.white,
    error: const Color(0xFFFF3B30),
  ),

  scaffoldBackgroundColor: klookBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: klookBlack),
    actionsIconTheme: IconThemeData(color: klookBlack),
    titleTextStyle: TextStyle(
      color: klookBlack,
      fontFamily: 'Poppins',
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: klookOrange,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: klookOrange,
      side: const BorderSide(color: klookOrange),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.05),
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: klookSoftGray),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: klookSoftGray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: klookOrange, width: 1.5),
    ),
    hintStyle: const TextStyle(color: klookGray, fontSize: 14),
  ),

  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: klookBlack, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: klookBlack, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(color: klookBlack),
    bodySmall: TextStyle(color: klookGray),
  ),
);

import 'package:flutter/material.dart';
import '../modules/auth/pages/login_page.dart';
import '../modules/home/pages/home_page.dart';
import '../modules/profile/pages/profile_page.dart';
import '../modules/favorite/pages/favorite_page.dart';
import '../modules/my_kos/pages/my_kos_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String myTrip = '/my-trip';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginScreen(),
    profile: (context) => ProfilePage(),
    favorite: (context) => FavoritePage(),
    myTrip: (context) => MyTripPage(),
  };
}

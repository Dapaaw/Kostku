import 'package:get/get.dart';
import '/modules/auth/pages/login_page.dart';
import '/modules/home/pages/home_page.dart';
import '/modules/profile/pages/profile_page.dart';
import '/modules/favorite/pages/favorite_page.dart';
import '/modules/my_kos/pages/my_kos_page.dart';
import '/modules/home/pages/price_list_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String myTrip = '/my-trip';
  static const String priceList = '/price-list'; 
  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(
      name: login,
      page: () => const LoginScreen(), 
    ),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: favorite, page: () => const FavoritePage()),
    GetPage(name: myTrip, page: () => MyTripPage()),
    GetPage(name: priceList, page: () => const PriceListPage()),
  ];
}

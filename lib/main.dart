import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos/data/models/auth_controller.dart';

import '/config/theme.dart';
import '/routes/app_routes.dart';
import '/data/models/favorite_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kostku App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.getPages,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/theme.dart';
import '/routes/app_routes.dart';
import '/data/models/my_kos_controller.dart';
import '/data/models/favorite_controller.dart';
import '/data/models/kos_controller.dart';

void main() {
  Get.put(MyKosController());
  Get.put(FavoriteController());
  Get.put(KosController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kostku App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,      initialRoute: AppRoutes.home,
      getPages: AppRoutes.getPages,    );
  }
}

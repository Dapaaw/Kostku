import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kos/data/models/auth_controller.dart';
import '../services/api_service.dart';
import '../../routes/app_routes.dart';
import 'kos_model.dart';

class FavoriteController extends GetxController {
  final ApiService apiService = ApiService();

  final AuthController _authController = Get.find<AuthController>();

  final _favoriteIds = <int>{}.obs;
  var favoriteKosList = <KosModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (_authController.isLoggedIn.value) {
      fetchFavorites();
    }
  }

  Future<void> fetchFavorites() async {
    if (!_authController.isLoggedIn.value) return;
    try {
      final response = await apiService.getFavorites();
      if (response.statusCode == 200) {
        final List<dynamic> favoriteKosListJson = response.data['data'];
        favoriteKosList.assignAll(
          favoriteKosListJson.map((json) => KosModel.fromJson(json)).toList(),
        );
        _favoriteIds.clear();
        for (var kos in favoriteKosList) {
          _favoriteIds.add(kos.id);
        }
      }
    } on Exception catch (_) {}
  }

  void toggleFavorite(KosModel kos) async {
    if (!_authController.isLoggedIn.value) {
      Get.defaultDialog(
        title: 'Perlu Login',
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        middleText: 'Anda harus login untuk menambahkan favorit.',
        textConfirm: 'Login Sekarang',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.login);
        },
        textCancel: 'Batal',
        onCancel: () {},
      );
      return;
    }

    bool isCurrentlyFavorite = isFavorite(kos.id);
    try {
      if (isCurrentlyFavorite) {
        _favoriteIds.remove(kos.id);
        await apiService.removeFavorite(kos.id);
      } else {
        _favoriteIds.add(kos.id);
        await apiService.addFavorite(kos.id);
      }
    } catch (e) {
      if (isCurrentlyFavorite) {
        _favoriteIds.add(kos.id);
      } else {
        _favoriteIds.remove(kos.id);
      }
      Get.snackbar(
        'Error',
        'Gagal mengubah status favorit. Silakan coba lagi.',
      );
    } finally {
      update();
    }
  }

  bool isFavorite(int kosId) {
    return _favoriteIds.contains(kosId);
  }
}

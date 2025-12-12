import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kos/data/models/auth_controller.dart';
import '../services/api_service.dart';
import '../../routes/app_routes.dart';
import 'kos_model.dart';

class FavoriteController extends GetxController {
  final ApiService apiService = ApiService();
  // Gunakan Get.find dengan tag atau pastikan AuthController sudah ada
  final AuthController _authController = Get.find<AuthController>();

  // Set untuk menyimpan ID agar pengecekan isFavorite cepat
  final _favoriteIds = <int>{}.obs;

  // List untuk menyimpan Data Objek Kos (Gambar, Nama, Harga)
  var favoriteKosList = <KosModel>[].obs;

  var isLoading = false.obs; // Tambahan loading state

  @override
  void onInit() {
    super.onInit();
    // Coba ambil data saat controller dibuat
    if (_authController.isLoggedIn.value) {
      fetchFavorites();
    }

    // Opsional: Dengarkan perubahan status login
    ever(_authController.isLoggedIn, (loggedIn) {
      if (loggedIn) {
        fetchFavorites();
      } else {
        favoriteKosList.clear();
        _favoriteIds.clear();
      }
    });
  }

  Future<void> fetchFavorites() async {
    if (!_authController.isLoggedIn.value) return;

    try {
      isLoading.value = true;
      final response = await apiService.getFavorites();

      if (response.statusCode == 200) {
        // Sesuaikan parsing JSON ini dengan struktur Laravel kamu
        // Biasanya: response.data['data']
        final List<dynamic> data = response.data['data'];

        // Update List
        final List<KosModel> loadedKos = data
            .map((json) => KosModel.fromJson(json))
            .toList();
        favoriteKosList.assignAll(loadedKos);

        // Update IDs
        _favoriteIds.clear();
        for (var kos in loadedKos) {
          _favoriteIds.add(kos.id);
        }
      }
    } catch (e) {
      print("Error fetching favorites: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(KosModel kos) async {
    // 1. Cek Login
    if (!_authController.isLoggedIn.value) {
      Get.defaultDialog(
        title: 'Perlu Login',
        middleText: 'Anda harus login untuk menambahkan favorit.',
        textConfirm: 'Login',
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.login);
        },
        textCancel: 'Batal',
      );
      return;
    }

    bool isCurrentlyFavorite = isFavorite(kos.id);

    // 2. Optimistic UI Update (Update Tampilan Dulu Biar Cepat)
    if (isCurrentlyFavorite) {
      _favoriteIds.remove(kos.id);
      // PENTING: Hapus juga dari List Objek
      favoriteKosList.removeWhere((item) => item.id == kos.id);
    } else {
      _favoriteIds.add(kos.id);
      // PENTING: Tambahkan ke List Objek
      favoriteKosList.add(kos);
    }

    // 3. Panggil API di Background
    try {
      if (isCurrentlyFavorite) {
        await apiService.removeFavorite(kos.id);
      } else {
        await apiService.addFavorite(kos.id);
      }
    } catch (e) {
      // Jika API Gagal, Rollback (Kembalikan seperti semula)
      if (isCurrentlyFavorite) {
        _favoriteIds.add(kos.id);
        favoriteKosList.add(kos);
      } else {
        _favoriteIds.remove(kos.id);
        favoriteKosList.removeWhere((item) => item.id == kos.id);
      }

      Get.snackbar(
        'Gagal',
        'Gagal menyinkronkan favorit. Periksa koneksi internet.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool isFavorite(int kosId) {
    return _favoriteIds.contains(kosId);
  }
}

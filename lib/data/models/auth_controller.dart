import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoggedIn = false.obs;
  var userName = 'Guest'.obs;
  var userEmail = 'Silakan login'.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      isLoggedIn.value = false;
      userName.value = 'Guest';
      userEmail.value = 'Silakan login';
    } else {
      isLoggedIn.value = true;
      userName.value = prefs.getString('userName') ?? 'User';
      userEmail.value = prefs.getString('userEmail') ?? 'No Email';
    }
  }

  Future<void> updateUserProfile(String newName, String newEmail) async {
    if (newName == userName.value && newEmail == userEmail.value) {
      Get.back();
      return;
    }

    isLoading.value = true;
    try {
      final response = await apiService.updateProfile(
        fullName: newName,
        email: newEmail,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final updateName = response.data['data']?['full_name'] ?? newName;
        final updateEmail = response.data['data']?['email'] ?? newEmail;

        await prefs.setString('userName', updateName);
        await prefs.setString('userEmail', updateEmail);

        loadInitialData();

        Get.back(result: true);
        Get.snackbar(
          'Berhasil',
          'Profil berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Gagal',
          'Terjadi kesalahan saat memperbarui profil',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Gagal',
        e.response?.data['message'] ?? 'Gagal memperbarui profil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      // 1. Panggil API Login
      final response = await apiService.login(email, password);

      // 2. Ambil data dari respon server (Sesuaikan dengan JSON Laravel kamu)
      // Struktur umum: { "data": { "token": "...", "user": { ... } } }
      final responseData = response.data['data']; 
      final String token = responseData['token'];
      final String name = responseData['user']['name']; // atau 'full_name'
      final String emailUser = responseData['user']['email'];

      // 3. PENTING: Simpan Token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);       // KUNCI UTAMA AGAR FAVORIT BISA JALAN
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', emailUser);

      // 4. Update State Aplikasi
      isLoggedIn.value = true;
      userName.value = name;
      userEmail.value = emailUser;

      Get.back(); // Tutup halaman login
      
      Get.snackbar(
        'Berhasil', 
        'Selamat datang kembali, $name!',
        backgroundColor: Colors.green, 
        colorText: Colors.white
      );

    } on DioException catch (e) {
      // Handle error login (Password salah dll)
      Get.snackbar(
        'Login Gagal', 
        e.response?.data['message'] ?? 'Email atau password salah',
        backgroundColor: Colors.red, 
        colorText: Colors.white
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void>changePassword(String oldPassword, String newPassword, String confirmPassword) async {

      if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
        Get.snackbar(
          'Gagal',
          'Kata sandi tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
        return;
      } 
      if (newPassword != confirmPassword) {
        Get.snackbar(
          'Gagal',
          'Password baru dan konfirmasi tidak sesuai',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
        return;
      }
      isLoading.value = true;
    try {
      final response = await apiService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirmation: confirmPassword,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Kata sandi berhasil diubah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Gagal',
          'Terjadi kesalahan saat mengubah kata sandi',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
        );
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Gagal',
        e.response?.data['message'] ?? 'Gagal mengubah kata sandi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

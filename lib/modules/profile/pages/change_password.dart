import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/theme.dart';
import '/data/models/auth_controller.dart';

class ChangePasswordPage extends GetView<AuthController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final RxBool oldPasswordObscured = true.obs;
    final RxBool newPasswordObscured = true.obs;
    final RxBool confirmPasswordObscured = true.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Ganti Password'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Password Lama',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: klookGray,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return TextField(
                controller: oldPasswordController,
                obscureText: oldPasswordObscured.value,
                decoration: InputDecoration(
                  hintText: 'Masukkan password lama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: klookBackground,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      oldPasswordObscured.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      oldPasswordObscured.value = !oldPasswordObscured.value;
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              );
            }),
            const SizedBox(height: 24),

            const Text(
              'Password Baru',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: klookGray,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return TextField(
                controller: newPasswordController,
                obscureText: newPasswordObscured.value,
                decoration: InputDecoration(
                  hintText: 'Masukkan password baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: klookBackground,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      newPasswordObscured.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      newPasswordObscured.value = !newPasswordObscured.value;
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              );
            }),
            const SizedBox(height: 24),

            const Text(
              'Konfirmasi Password Baru',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: klookGray,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return TextField(
                controller: confirmPasswordController,
                obscureText: confirmPasswordObscured.value,
                decoration: InputDecoration(
                  hintText: 'Ulangi password baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: klookBackground,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmPasswordObscured.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      confirmPasswordObscured.value =
                          !confirmPasswordObscured.value;
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              );
            }),
            const SizedBox(height: 40),

            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        controller.changePassword(
                          oldPasswordController.text,
                          newPasswordController.text,
                          confirmPasswordController.text,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Simpan Password Baru',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

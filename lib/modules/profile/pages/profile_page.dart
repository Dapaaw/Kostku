import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kos/data/models/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/api_service.dart';
import '/data/models/favorite_controller.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/config/theme.dart';
import '/routes/app_routes.dart';
import 'change_password.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final FavoriteController favController = Get.find<FavoriteController>();
  final AuthController authController = Get.find<AuthController>();

  Future<void> _logout() async {
    final ApiService apiService = ApiService();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await apiService.logout();
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      await prefs.remove('token');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
      Get.find<AuthController>().loadInitialData();
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
              backgroundColor: klookSoftGray,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Column(
                children: [
                  Text(
                    authController.userName.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: klookBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    authController.userEmail.value,
                    style: const TextStyle(fontSize: 16, color: klookGray),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Personal Info"),
                    trailing: const Icon(Icons.chevron_right, size: 16),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield),
                    title: const Text("Privacy and Sharing"),
                    trailing: const Icon(Icons.chevron_right, size: 16),

                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text("Notifications"),
                    trailing: const Icon(Icons.chevron_right, size: 16),

                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat_bubble),
                    title: const Text("Review"),
                    trailing: const Icon(Icons.chevron_right, size: 16),
                    onTap: () {},
                  ),
                  Obx(() {
                    if (authController.isLoggedIn.value) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.edit,
                              color: klookOrange,
                            ),
                            title: const Text(
                              "Edit Profile",
                              style: TextStyle(color: klookOrange),
                            ),
                            trailing: const Icon(Icons.chevron_right, size: 16),
                            onTap: () async {
                              var result = await Get.toNamed(
                                AppRoutes.editProfile,
                              );
                              if (result == true) {
                                Get.snackbar(
                                  "Success",
                                  "Profile updated successfully.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: klookOrange,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(16),
                                );
                              }
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          ListTile(
                            leading: const Icon(
                              Icons.lock,
                              color: klookOrange,
                            ),
                            title: const Text(
                              "Change Password",
                              style: TextStyle(color: klookOrange),
                            ),
                            trailing: const Icon(Icons.chevron_right, size: 16),
                            onTap: () async {
                              var result = await Get.to(
                                () => ChangePasswordPage(),
                              );

                              if (result == true) {
                                Get.snackbar(
                                  "Success",
                                  "Password changed successfully.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: klookOrange,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(16),
                                );
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              _logout();
                            },
                          ),
                        ],
                      );
                    } else {
                      return ListTile(
                        leading: const Icon(Icons.login, color: klookOrange),
                        title: const Text(
                          "Login/Register",
                          style: TextStyle(color: klookOrange),
                        ),
                        onTap: () {
                          Get.toNamed(AppRoutes.login);
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          if (index == 0) {
            Get.offNamed(AppRoutes.home);
          } else if (index == 1) {
            Get.offNamed(AppRoutes.myTrip);
          } else if (index == 2) {
            Get.offNamed(AppRoutes.favorite);
          }
        },
      ),
    );
  }
}

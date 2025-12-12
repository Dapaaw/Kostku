import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/modules/home/widgets/nearby_property_card.dart';
import '/data/models/my_kos_controller.dart';
import '/data/models/favorite_controller.dart';
import '/data/models/auth_controller.dart';
import '/routes/app_routes.dart';

class MyTripPage extends StatelessWidget {
  MyTripPage({super.key});
  final FavoriteController favController = Get.find<FavoriteController>();
  final AuthController authController = Get.find<AuthController>();

  // Pastikan pakai Get.put disini agar controller terbuat
  final MyKosController myKosController = Get.find<MyKosController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Kos'), centerTitle: true),

      // --- PERBAIKAN 2: Ganti GetBuilder dengan Obx ---
      body: Obx(() {
        // 1. Cek Login
        if (!authController.isLoggedIn.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'Silakan login untuk melihat kos Anda.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: const Text('Login Sekarang'),
                  ),
                ],
              ),
            ),
          );
        }

        // 2. Cek Jika List Kosong (PENTING biar user tau)
        if (myKosController.myKosList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 60,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                const Text("Belum ada kos yang dipesan"),
              ],
            ),
          );
        }

        // 3. Render List
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: myKosController.myKosList.length,
          itemBuilder: (context, index) {
            final kos = myKosController.myKosList[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  // Gunakan Obx lagi atau GetBuilder untuk favController (opsional)
                  GetBuilder<FavoriteController>(
                    init: favController,
                    builder: (favController) {
                      return NearbyPropertyCard(
                        propertyId: kos.id.toString(),
                        imageUrl: kos.imageUrl,
                        title: kos.name,
                        location: kos.location,
                        price: "Rp ${kos.price.toInt()}",
                        rating: kos.rating,
                        isFavorite: favController.isFavorite(kos.id),
                        onFavoriteToggle: () {
                          favController.toggleFavorite(kos);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  // Row untuk 2 tombol: Review dan Hapus
                  Row(
                    children: [
                      // Tombol Review
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.star_outline,
                            size: 20,
                          ),
                          label: const Text('Beri Ulasan'),
                          onPressed: () async {
                            final result = await Get.toNamed(
                              AppRoutes.review,
                              arguments: kos,
                            );
                            
                            if (result == true) {
                              Get.snackbar(
                                'Berhasil',
                                'Ulasan Anda telah dikirim!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green[400],
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[400],
                            foregroundColor: Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Tombol Hapus
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Batalkan',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            // Dialog konfirmasi
                            Get.defaultDialog(
                              title: 'Batalkan Pesanan?',
                              middleText: 'Apakah Anda yakin ingin membatalkan pesanan ${kos.name}?',
                              textConfirm: 'Ya, Batalkan',
                              textCancel: 'Tidak',
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              onConfirm: () {
                                myKosController.removeMyKos(kos.id);
                                Get.back();
                                Get.snackbar(
                                  "Dibatalkan",
                                  "Pesanan berhasil dibatalkan",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red[400],
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.red.shade200),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0)
            Get.offNamed(AppRoutes.home);
          else if (index == 2)
            Get.offNamed(AppRoutes.favorite);
          else if (index == 3)
            Get.offNamed(AppRoutes.profile);
        },
      ),
    );
  }
}

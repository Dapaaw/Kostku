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
  final MyKosController myKosController = Get.put(MyKosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Kos'), centerTitle: true),
      body: GetBuilder<MyKosController>(
        init: myKosController,
        builder: (myKosController) {
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
                      'Silakan login untuk melihat kos favorit Anda.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login sekarang untuk mengakses fitur favorit dan banyak lagi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Login Sekarang'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: myKosController.myKosList.length,
            itemBuilder: (context, index) {
              final kos = myKosController.myKosList[index];
              if (kos.imageUrl.isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.star_outline, size: 20),
                        label: const Text('Beri ulasan'),
                        onPressed: () async{
                          var result = await Get.toNamed(
                            AppRoutes.review,
                            arguments: kos,
                          );

                          if(result == true){
                            Get.snackbar(
                              'Berhasil terkirim',
                              'Ulasan anda telah berhasil disimpan',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(16.0)
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                          side: BorderSide(color: Colors.grey.shade300),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0) {
            Get.offNamed(AppRoutes.home);
          } else if (index == 2) {
            Get.offNamed(AppRoutes.favorite);
          } else if (index == 3) {
            Get.offNamed(AppRoutes.profile);
          }
        },
      ),
    );
  }
}

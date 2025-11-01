import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/modules/home/widgets/nearby_property_card.dart';
import '/data/models/favorite_controller.dart';
import '/routes/app_routes.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.find<FavoriteController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Kost'), centerTitle: true),
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          if (controller.favoriteList.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada kos favorit.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.favoriteList.length,
            itemBuilder: (context, index) {
              final kos = controller.favoriteList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: NearbyPropertyCard(
                  propertyId: kos.id.toString(),
                  imageUrl: kos.imageUrl,
                  title: kos.name,
                  location: kos.location,
                  price: "Rp ${kos.price}",
                  rating: kos.rating,
                  isFavorite: true,
                  onFavoriteToggle: () {
                    controller.toggleFavorite(kos);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        onTap: (index) {
          if (index == 2) return;
          if (index == 0) {
            Get.offNamed(AppRoutes.home);
          } else if (index == 1) {
            Get.offNamed(AppRoutes.myTrip);
          } else if (index == 3) {
            Get.offNamed(AppRoutes.profile);
          }
        },
      ),
    );
  }
}

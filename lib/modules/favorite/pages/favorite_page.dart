import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/widgets/nearby_property_card.dart';
import '../../home/pages/property_detail_page.dart'; 
import '/data/models/kos_model.dart';
import '/data/models/favorite_controller.dart';
import '/config/formatter.dart';
import '../../home/widgets/bottom_navbar.dart'; 
import '/routes/app_routes.dart'; 

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favController = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Kos Favorit'), centerTitle: true),
      
      body: Obx(() {
        final List<KosModel> favoriteKosList = favController.favoriteKosList
            .where((kos) => favController.isFavorite(kos.id))
            .toList();

        if (favoriteKosList.isEmpty) {
          return Center(
            child: Text(
              'Belum ada kos favorit.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favoriteKosList.length,
          itemBuilder: (context, index) {
            final kos = favoriteKosList[index];

            return InkWell(
              onTap: () {
                Get.to(() => PropertyDetailPage(property: kos));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: NearbyPropertyCard(
                  propertyId: kos.id.toString(),
                  imageUrl: kos.imageUrl,
                  title: kos.name,
                  location: kos.location,
                  price: "${currencyFormatter.format(kos.price)} / bulan",
                  rating: kos.rating,
                  isFavorite: favController.isFavorite(kos.id),
                  onFavoriteToggle: () {
                    favController.toggleFavorite(kos);
                  },
                ),
              ),
            );
          },
        );
      }),

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
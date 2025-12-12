import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/widgets/nearby_property_card.dart';
import '../../home/pages/property_detail_page.dart';
import '/data/models/kos_model.dart';
import '/data/models/favorite_controller.dart';
import '../../home/widgets/bottom_navbar.dart';
import '/routes/app_routes.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cari controller
    final FavoriteController favController = Get.find<FavoriteController>();

    // PENTING: Panggil fetch data setiap buka halaman ini
    // Agar data selalu sinkron dengan server
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favController.fetchFavorites();
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Kos Favorit'), centerTitle: true),

      body: Obx(() {
        // Tampilkan Loading jika sedang fetch
        if (favController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Ambil list langsung dari controller
        final List<KosModel> favoriteKosList = favController.favoriteKosList;

        if (favoriteKosList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 60, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'Belum ada kos favorit.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
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
                  price: "Rp ${kos.price.toInt()}", // Sesuaikan formatter kamu
                  rating: kos.rating,
                  isFavorite: true, // Di halaman ini pasti true
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
            Get.offNamed(AppRoutes.myTrip); // Pastikan nama route benar
          } else if (index == 3) {
            Get.offNamed(AppRoutes.profile);
          }
        },
      ),
    );
  }
}

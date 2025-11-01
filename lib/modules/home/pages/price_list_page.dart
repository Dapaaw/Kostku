import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/nearby_property_card.dart';
import '../pages/property_detail_page.dart';
import '/data/models/kos_model.dart';
import '/data/models/favorite_controller.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({super.key});

  @override
  Widget build(BuildContext context) {

    final arguments = Get.arguments;
    String title = 'Daftar Kos';

    List<KosModel> kosList = [];

    if (arguments != null && arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? 'Daftar Kos';
      kosList = arguments['kosList'] ?? [];
    }

    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Kos'), centerTitle: true),

      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          if (kosList.isEmpty) {
            return const Center(child: Text('Tidak ada kos tersedia.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: kosList.length,
            itemBuilder: (context, index) {
              final kos = kosList[index];

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
                    price: "Rp ${kos.price.toInt()}",
                    rating: kos.rating,
                    isFavorite: controller.isFavorite(kos.id),
                    onFavoriteToggle: () {
                      controller.toggleFavorite(kos);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

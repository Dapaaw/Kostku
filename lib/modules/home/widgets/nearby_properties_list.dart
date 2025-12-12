import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/kos_model.dart';
import '/data/models/favorite_controller.dart';
import '/modules/home/widgets/nearby_property_card.dart';
import '/modules/home/pages/property_detail_page.dart';
import '/config/formatter.dart';

class NearbyPropertiesList extends StatelessWidget {
  final List<KosModel> properties;
  final FavoriteController favoriteController;

  const NearbyPropertiesList({
    super.key,
    required this.properties,
    required this.favoriteController,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Center(
          child: Text(
            'Tidak ada kos ditemukan di lokasi ini.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final kos = properties[index];

        // --- PERBAIKAN: BUNGKUS DENGAN OBX ---
        // Obx akan membuat widget ini "mendengarkan" perubahan di favoriteController.
        // Begitu tombol ditekan, ikon akan langsung berubah merah/putih.
        return Obx(() {
          return InkWell(
            onTap: () {
              Get.to(() => PropertyDetailPage(property: kos));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: NearbyPropertyCard(
                propertyId: kos.id.toString(),
                imageUrl: kos.imageUrl,
                title: kos.name,
                location: kos.location,
                price: "${currencyFormatter.format(kos.price)} / bulan",
                rating: kos.rating,

                // Karena dibungkus Obx, baris ini sekarang menjadi Reactive (Real-time)
                isFavorite: favoriteController.isFavorite(kos.id),

                onFavoriteToggle: () => favoriteController.toggleFavorite(kos),
              ),
            ),
          );
        });
        // -------------------------------------
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/kos_model.dart';
import '/data/models/favorite_controller.dart';
import '/modules/home/widgets/property_card.dart';
import '/modules/home/pages/property_detail_page.dart';
import '/config/formatter.dart';

class TopPropertiesList extends StatelessWidget {
  final List<KosModel> properties;
  final FavoriteController favoriteController;

  const TopPropertiesList({
    super.key,
    required this.properties,
    required this.favoriteController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          if (properties.isEmpty) {
            return Container(
              width: 200,
              alignment: Alignment.center,
              child: const Text(
                'Tidak ada kos di harga ini.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final kos = properties[index];
          return InkWell(
            onTap: () {
              Get.to(() => PropertyDetailPage(property: kos));
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index == properties.length - 1 ? 0 : 14,
              ),
              child: PropertyCard(
                propertyId: kos.id.toString(),
                imageUrl: kos.imageUrl,
                title: kos.name,
                location: kos.location,
                price: "${currencyFormatter.format(kos.price)} / bulan",
                rating: kos.rating,
                isFavorite: favoriteController.isFavorite(kos.id),
                onFavoriteToggle: () => favoriteController.toggleFavorite(kos),
              ),
            ),
          );
        },
      ),
    );
  }
}

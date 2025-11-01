import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/modules/home/widgets/nearby_property_card.dart';
import '/data/models/my_kos_controller.dart';
import '/data/models/favorite_controller.dart';
import '/routes/app_routes.dart';

class MyTripPage extends StatelessWidget {
  MyTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Kos'), centerTitle: true),
      body: GetBuilder<MyKosController>(
        builder: (myKosController) {

          if (myKosController.myKosList.isEmpty) {
            return const Center(
              child: Text(
                'Anda belum memesan kos apapun.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
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
                child: GetBuilder<FavoriteController>(
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

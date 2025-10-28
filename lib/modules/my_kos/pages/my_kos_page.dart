import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../home/widgets/bottom_navbar.dart';
import '../../home/pages/home_page.dart';
import '../../favorite/pages/favorite_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../home/widgets/nearby_property_card.dart';
import '../../../data/models/my_kos_controller.dart'; 
import '../../../data/models/favorite_controller.dart'; 

class MyTripPage extends StatelessWidget {
  const MyTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myKosController = Get.put(MyKosController());
    final favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(title: const Text('My Kos'), centerTitle: true),
      body: Obx(() {
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
      }),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FavoritePage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}

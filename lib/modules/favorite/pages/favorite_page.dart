// [ FILE: favorite_page.dart ]
// Salin dan ganti seluruh kode di file Anda dengan ini.

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../modules/home/widgets/bottom_navbar.dart';
import '../../../modules/home/pages/home_page.dart';
import '../../../modules/my_trip/pages/my_trip_page.dart';
import '../../../modules/profile/pages/profile_page.dart';
import '../../../modules/home/widgets/nearby_property_card.dart';
import '../../../data/models/favorite_controller.dart'; 

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Hotels'),
        centerTitle: true,
      ),
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
              final hotel = controller.favoriteList[index]; 

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: NearbyPropertyCard(
                  propertyId: hotel.id.toString(),
                  imageUrl: hotel.imageUrl,
                  title: hotel.name,
                  location: hotel.location,
                  price: "Rp ${hotel.price}",
                  isFavorite: true, 
                  onFavoriteToggle: () {
                    controller.toggleFavorite(hotel); 
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyTripPage()),
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
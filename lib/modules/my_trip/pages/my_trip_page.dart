import 'package:flutter/material.dart';
import '../../home/widgets/bottom_navbar.dart';
import '../../home/pages/home_page.dart';
import '../../favorite/pages/favorite_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../../data/models/hotel_model.dart';
import '../../home/widgets/nearby_property_card.dart';

class MyTripPage extends StatelessWidget {
  const MyTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myKosList = [
      HotelModel(
        id: 10,
        name: 'Kos Anda Saat Ini',
        location: 'Jakarta Selatan',
        price: 2100000,
        imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400', 
        rating: 4.9,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Kos'), centerTitle: true),
      body: ListView.builder(
        // Tambahkan padding
        padding: const EdgeInsets.all(16.0),
        itemCount: myKosList.length,
        itemBuilder: (context, index) {
          final kos = myKosList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: NearbyPropertyCard(
              propertyId: kos.id.toString(),
              imageUrl: kos.imageUrl, 
              title: kos.name,
              location: kos.location,
              price: "Rp ${kos.price}",
              isFavorite: true,
              onFavoriteToggle: () {
                print("Toggle favorit: ${kos.name}");
              },
            ),
          );
        },
      ),
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

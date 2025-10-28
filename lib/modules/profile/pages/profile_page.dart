import 'package:flutter/material.dart';
import '../../../modules/home/widgets/bottom_navbar.dart';
import '../../../modules/home/pages/home_page.dart';
import '../../../modules/my_trip/pages/my_trip_page.dart';
import '../../../modules/favorite/pages/favorite_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/profile.jpg',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Daffa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("daffa@email.com", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Personal Info"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.shield),
              title: const Text("Privacy and Sharing"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble),
              title: const Text("Review"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3,
        onTap: (index) {
          if (index == 3) return; 
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
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FavoritePage()),
            );
          }    
        },
      ),
    );
  }
}

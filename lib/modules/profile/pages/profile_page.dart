import 'package:flutter/material.dart';
import '../../../modules/home/widgets/bottom_navbar.dart';
import '../../../modules/home/pages/home_page.dart';
import '../../my_kos/pages/my_kos_page.dart';
import '../../../modules/favorite/pages/favorite_page.dart';
import '../../../config/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              "Daffa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "daffa@email.com",
              style: TextStyle(color: travelokaMediumGray),
            ),

            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Personal Info"),
                    trailing: const Icon(Icons.chevron_right, size: 16),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield),
                    title: const Text("Privacy and Sharing"),
                    trailing: const Icon(Icons.chevron_right, size: 16),

                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text("Notifications"),
                    trailing: const Icon(Icons.chevron_right, size: 16),

                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat_bubble),
                    title: const Text("Review"),
                    trailing: const Icon(Icons.chevron_right, size: 16),
                    onTap: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../data/models/favorite_controller.dart';
import '../../../data/models/hotel_model.dart'; 
import '../widgets/header.dart';
import '../widgets/header_cari.dart';
import '../widgets/top_nearby_header.dart';
import '../widgets/property_card.dart';
import '../widgets/nearby_property_card.dart';
import '../widgets/bottom_navbar.dart';
import '../../../config/theme.dart';
import '../../../modules/home/pages/property_detail_page.dart';
import '../../../modules/home/pages/price_list_page.dart';
import '../../../modules/my_trip/pages/my_trip_page.dart';
import '../../../modules/favorite/pages/favorite_page.dart';
import '../../../modules/profile/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedPriceRange = 'Rp 450.000 - Rp 1.000.000';
  String _selectedLocation = 'Lowokwaru';

  final List<String> _priceRanges = [
    'Rp 450.000 - Rp 1.000.000',
    'Rp 1.100.000 - Rp 1.500.000',
    'Rp 1.600.000 - Rp 2.000.000',
    'Rp 2.100.000 - Rp 3.000.000',
  ];

  final List<String> _locations = ['Lowokwaru', 'Sukun', 'Klojen', 'Blimbing'];

  final HotelModel gardeniaPrime = HotelModel(
    id: 1, 
    name: 'Gardenia Prime',
    location: 'Sukun',
    price: 1200000,
    imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
    rating: 4.5, 
  );

  final HotelModel sansivera = HotelModel(
    id: 2,
    name: 'Sansivera',
    location: 'Lowokwaru',
    price: 1650000,
    imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
    rating: 4.6,
  );

  final HotelModel putriBungah = HotelModel(
    id: 3,
    name: 'PutriBungah',
    location: 'Klojen',
    price: 475000,
    imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
    rating: 4.3,
  );

  final HotelModel bestariIndah = HotelModel(
    id: 4,
    name: 'Perum Bestari Indah',
    location: 'Sukun',
    price: 550000,
    imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
    rating: 4.4,
  );

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: GetBuilder<FavoriteController>(
        builder: (controller) { 
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  SearchAndFilterSection(
                    priceRanges: _priceRanges,
                    selectedPriceRange: _selectedPriceRange,
                    onSeeAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PriceListPage()),
                      );
                    },
                    onPriceRangeSelected: (range) {
                      setState(() {
                        _selectedPriceRange = range;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 230,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => PropertyDetailPage(propertyId: gardeniaPrime.id.toString())),
                            );
                          },
                          child: PropertyCard(
                            propertyId: gardeniaPrime.id.toString(),
                            imageUrl: gardeniaPrime.imageUrl,
                            title: gardeniaPrime.name,
                            location: gardeniaPrime.location,
                            price: "Rp ${gardeniaPrime.price}", 
                            priceRange: 'Rp 450.000 - Rp 1.000.000', 
                            
                            isFavorite: controller.isFavorite(gardeniaPrime.id),
                            onFavoriteToggle: () => controller.toggleFavorite(gardeniaPrime),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => PropertyDetailPage(propertyId: sansivera.id.toString())),
                            );
                          },
                          child: PropertyCard(
                            propertyId: sansivera.id.toString(),
                            imageUrl: sansivera.imageUrl,
                            title: sansivera.name,
                            location: sansivera.location,
                            price: "Rp ${sansivera.price}",
                            priceRange: 'Rp 1.100.000 - Rp 1.500.000',
                            
                            isFavorite: controller.isFavorite(sansivera.id),
                            onFavoriteToggle: () => controller.toggleFavorite(sansivera),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TopNearbyHeader(
                    locations: _locations,
                    selectedLocation: _selectedLocation,
                    onLocationChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PropertyDetailPage(propertyId: putriBungah.id.toString())),
                          );
                        },
                        child: NearbyPropertyCard(
                          propertyId: putriBungah.id.toString(),
                          imageUrl: putriBungah.imageUrl,
                          title: putriBungah.name,
                          location: putriBungah.location,
                          price: "Rp ${putriBungah.price}",
                          
                          isFavorite: controller.isFavorite(putriBungah.id),
                          onFavoriteToggle: () => controller.toggleFavorite(putriBungah),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PropertyDetailPage(propertyId: bestariIndah.id.toString())),
                          );
                        },
                        child: NearbyPropertyCard(
                          propertyId: bestariIndah.id.toString(),
                          imageUrl: bestariIndah.imageUrl,
                          title: bestariIndah.name,
                          location: bestariIndah.location,
                          price: "Rp ${bestariIndah.price}",
                          
                          isFavorite: controller.isFavorite(bestariIndah.id),
                          onFavoriteToggle: () => controller.toggleFavorite(bestariIndah),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyTripPage()),
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
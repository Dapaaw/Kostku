import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/favorite_controller.dart';
import '../../../data/models/kos_model.dart';
import '../widgets/header.dart';
import '../widgets/header_cari.dart';
import '../widgets/top_nearby_header.dart';
import '../widgets/property_card.dart';
import '../widgets/nearby_property_card.dart';
import '../widgets/bottom_navbar.dart';
import '../../../config/theme.dart';
import '../../../modules/home/pages/property_detail_page.dart';
import '../../../modules/home/pages/price_list_page.dart';
import '../../my_kos/pages/my_kos_page.dart';
import '../../../modules/favorite/pages/favorite_page.dart';
import '../../../modules/profile/pages/profile_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  final List<KosModel> topProperties = [
    KosModel(
      id: 1,
      name: 'Gardenia Prime',
      location: 'Sukun',
      price: 1200000,
      imageUrl:
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
      rating: 4.5,
      bedrooms: 4,
      bathrooms: 2,
      kitchen: 1,
      description:
          'Kos eksklusif dengan fasilitas lengkap dan lokasi strategis di pusat kota.',
      galleryImageUrls: [
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        'https://images.unsplash.com/photo-1501183638714-8c3b2e38f3f1?w=400',
        'https://images.unsplash.com/photo-1494526585095-c41746248156?w=400',
      ],
    ),
    KosModel(
      id: 2,
      name: 'Sansivera',
      location: 'Lowokwaru',
      price: 1650000,
      imageUrl:
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
      rating: 4.6,
      bedrooms: 4,
      bathrooms: 2,
      kitchen: 1,
      description:
          'Kos eksklusif dengan fasilitas lengkap dan lokasi strategis di pusat kota.',
      galleryImageUrls: [
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        'https://images.unsplash.com/photo-1501183638714-8c3b2e38f3f1?w=400',
        'https://images.unsplash.com/photo-1494526585095-c41746248156?w=400',
      ],
    ),
  ];

  final List<KosModel> nearbyProperties = [
    KosModel(
      id: 3,
      name: 'PutriBungah',
      location: 'Klojen',
      price: 475000,
      imageUrl:
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
      rating: 4.3,
      bedrooms: 4,
      bathrooms: 2,
      kitchen: 1,
      description:
          'Kos eksklusif dengan fasilitas lengkap dan lokasi strategis di pusat kota.',
      galleryImageUrls: [
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        'https://images.unsplash.com/photo-1501183638714-8c3b2e38f3f1?w=400',
        'https://images.unsplash.com/photo-1494526585095-c41746248156?w=400',
      ],
    ),
    KosModel(
      id: 4,
      name: 'Perum Bestari Indah',
      location: 'Sukun',
      price: 550000,
      imageUrl:
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
      rating: 4.4,
      bedrooms: 4,
      bathrooms: 2,
      kitchen: 1,
      description:
          'Kos eksklusif dengan fasilitas lengkap dan lokasi strategis di pusat kota.',
      galleryImageUrls: [
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        'https://images.unsplash.com/photo-1501183638714-8c3b2e38f3f1?w=400',
        'https://images.unsplash.com/photo-1494526585095-c41746248156?w=400',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        MaterialPageRoute(
                          builder: (_) => const PriceListPage(),
                        ),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: topProperties.length,
                      itemBuilder: (context, index) {
                        final kos = topProperties[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyDetailPage(
                                  property: kos,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: index == topProperties.length - 1 ? 0 : 8,
                            ),
                            child: PropertyCard(
                              propertyId: kos.id.toString(),
                              imageUrl: kos.imageUrl,
                              title: kos.name,
                              location: kos.location,
                              price: "Rp ${kos.price.toInt()}",
                              rating: kos.rating,
                              isFavorite: controller.isFavorite(kos.id),
                              onFavoriteToggle: () =>
                                  controller.toggleFavorite(kos),
                            ),
                          ),
                        );
                      },
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

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: nearbyProperties.length,
                    itemBuilder: (context, index) {
                      final kos = nearbyProperties[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyDetailPage(
                                property: kos,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: NearbyPropertyCard(
                            propertyId: kos.id.toString(),
                            imageUrl: kos.imageUrl,
                            title: kos.name,
                            location: kos.location,
                            price: "Rp ${kos.price.toInt()}",
                            rating: kos.rating,
                            isFavorite: controller.isFavorite(kos.id),
                            onFavoriteToggle: () =>
                                controller.toggleFavorite(kos),
                          ),
                        ),
                      );
                    },
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/favorite_controller.dart';
import '/data/models/kos_model.dart';
import '/data/models/kos_controller.dart';

import '/modules/home/widgets/header.dart';
import '/modules/home/widgets/header_cari.dart';
import '/modules/home/widgets/top_nearby_header.dart';
import '/modules/home/widgets/property_card.dart';
import '/modules/home/widgets/nearby_property_card.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/modules/home/pages/property_detail_page.dart';
import '/modules/home/pages/price_list_page.dart';
import '/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt _selectedIndex = 0.obs;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<FavoriteController>(
        builder: (favController) {
          return GetBuilder<KosController>(
            builder: (kosController) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      SearchAndFilterSection(
                        onSeeAllPressed: () {
                          final List<KosModel> allProperties = [
                            ...kosController.allTopProperties,
                            ...kosController.allNearbyProperties,
                          ];

                          Get.to(
                            () => const PriceListPage(),
                            arguments: {
                              'title': 'Semua Kos',
                              'kos_list': allProperties,
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: kosController.filteredTopProperties.length,
                          itemBuilder: (context, index) {
                            if (kosController.filteredTopProperties.isEmpty) {
                              return Container(
                                width: 200,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Tidak ada kos di harga ini.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }

                            final kos =
                                kosController.filteredTopProperties[index];
                            return InkWell(
                              onTap: () {
                                Get.to(() => PropertyDetailPage(property: kos));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right:
                                      index ==
                                          kosController
                                                  .filteredTopProperties
                                                  .length -
                                              1
                                      ? 0
                                      : 14,
                                ),
                                child: PropertyCard(
                                  propertyId: kos.id.toString(),
                                  imageUrl: kos.imageUrl,
                                  title: kos.name,
                                  location: kos.location,
                                  price: "Rp ${kos.price.toInt()}",
                                  rating: kos.rating,
                                  isFavorite: favController.isFavorite(kos.id),
                                  onFavoriteToggle: () =>
                                      favController.toggleFavorite(kos),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      TopNearbyHeader(
                        locations: kosController.locations,
                        selectedLocation: kosController.selectedLocation,
                        onLocationChanged: (String? newValue) {
                          kosController.updateLocation(newValue);
                        },
                      ),
                      const SizedBox(height: 16),
                      if (kosController.filteredNearbyProperties.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 20.0,
                          ),
                          child: Center(
                            child: Text(
                              'Tidak ada kos ditemukan di lokasi ini.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount:
                              kosController.filteredNearbyProperties.length,
                          itemBuilder: (context, index) {
                            final kos =
                                kosController.filteredNearbyProperties[index];
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
                                  price: "Rp ${kos.price.toInt()}",
                                  rating: kos.rating,
                                  isFavorite: favController.isFavorite(kos.id),
                                  onFavoriteToggle: () =>
                                      favController.toggleFavorite(kos),
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
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavBar(
          selectedIndex: _selectedIndex.value,
          onTap: (index) {
            _selectedIndex.value = index;
            if (index == 0) return;
            if (index == 1) {
              Get.offNamed(AppRoutes.myTrip);
            } else if (index == 2) {
              Get.offNamed(AppRoutes.favorite);
            } else if (index == 3) {
              Get.offNamed(AppRoutes.profile);
            }
          },
        );
      }),
    );
  }
}

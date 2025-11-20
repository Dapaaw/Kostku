import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/models/favorite_controller.dart';
import '/data/models/kos_model.dart';
import '/data/models/kos_controller.dart';

import '/modules/home/widgets/header.dart';
import '/modules/home/widgets/header_cari.dart';
import '/modules/home/widgets/top_nearby_header.dart';
import '/modules/home/widgets/bottom_navbar.dart';
import '/modules/home/widgets/error_state_widget.dart';
import '/modules/home/widgets/top_properties_list.dart';
import '/modules/home/widgets/nearby_properties_list.dart';
import '/modules/home/pages/price_list_page.dart';
import '/routes/app_routes.dart';
import 'package:get/get.dart' as getx;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 0.obs;
    final FavoriteController favController = Get.find<FavoriteController>();
    final KosController kosController = Get.put(KosController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<FavoriteController>(
        init: favController,
        builder: (favController) {
          return GetBuilder<KosController>(
            init: kosController,
            builder: (kosController) {
              return Obx(() {
                if (kosController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (kosController.errorMessage.value.isNotEmpty) {
                  return ErrorStateWidget(
                    errorMessage: kosController.errorMessage.value,
                    onRetry: () => kosController.fetchKosFromApi(),
                  );
                }
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        SearchAndFilterSection(
                          onSeeAllPressed: () {
                            final List<KosModel> filteredProperties =
                                kosController.filteredTopProperties;

                            getx.Get.to(
                              () => const PriceListPage(),
                              arguments: {
                                'title': 'Semua Kos',
                                'kos_list': filteredProperties,
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        TopPropertiesList(
                          properties: kosController.filteredTopProperties,
                          favoriteController: favController,
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
                        
                        NearbyPropertiesList(
                          properties: kosController.filteredNearbyProperties,
                          favoriteController: favController,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavBar(
          selectedIndex: selectedIndex.value,
          onTap: (index) {
            selectedIndex.value = index;
            if (index == 0) return;
            if (index == 1) {
              getx.Get.offNamed(AppRoutes.myTrip);
            } else if (index == 2) {
              getx.Get.offNamed(AppRoutes.favorite);
            } else if (index == 3) {
              getx.Get.offNamed(AppRoutes.profile);
            }
          },
        );
      }),
    );
  }
}

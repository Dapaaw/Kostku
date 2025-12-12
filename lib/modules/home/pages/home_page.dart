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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final selectedIndex = 0.obs;
    final FavoriteController favController = Get.find<FavoriteController>();
    // Gunakan put agar controller dibuat
    final KosController kosController = Get.put(KosController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // Gunakan Obx di root body untuk handle Loading & Error Global
      body: Obx(() {
        // 1. Cek Loading
        if (kosController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Cek Error Message
        if (kosController.errorMessage.value.isNotEmpty) {
          return ErrorStateWidget(
            errorMessage: kosController.errorMessage.value,
            onRetry: () => kosController.fetchKosFromApi(),
          );
        }

        // 3. Render Data jika Sukses
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(), // Pastikan const jika widget statis

                SearchAndFilterSection(
                  onSeeAllPressed: () {
                    final List<KosModel> filteredProperties =
                        kosController.filteredTopProperties;

                    Get.to(
                      () => const PriceListPage(),
                      arguments: {
                        'title': 'Semua Kos',
                        'kos_list': filteredProperties,
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                // List Top Properties
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

                // List Nearby Properties (Perbaikan Love ada di dalam file widget ini)
                NearbyPropertiesList(
                  properties: kosController.filteredNearbyProperties,
                  favoriteController: favController,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      }),

      bottomNavigationBar: Obx(() {
        return BottomNavBar(
          selectedIndex: selectedIndex.value,
          onTap: (index) {
            selectedIndex.value = index;
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

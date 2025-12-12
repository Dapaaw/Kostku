import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import Wajib
import 'package:kos/data/models/auth_controller.dart';

import '/config/theme.dart';
import '/data/models/kos_model.dart';
import '/data/models/my_kos_controller.dart';
import '/data/models/review_controller.dart';
import '/routes/app_routes.dart';
import '../../my_kos/pages/my_kos_page.dart';
import '../widgets/property_header_info.dart';
import '../widgets/property_statistics_row.dart';
import '../widgets/property_image_gallery.dart';
import '../widgets/property_review_section.dart';
import '../widgets/property_back_button.dart';

class PropertyDetailPage extends StatelessWidget {
  final KosModel property;

  PropertyDetailPage({super.key, required this.property});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Pastikan ReviewController dibuat
    final ReviewController reviewController = Get.put(
      ReviewController(kosId: property.id),
      tag:
          'review_${property.id}', // Best practice: kasih tag biar unik per kos
    );

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- PERUBAHAN: CachedNetworkImage untuk Header ---
                CachedNetworkImage(
                  imageUrl: property.imageUrl,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  // Optimasi Header (Resolusi agak tinggi tapi tetap dicache)
                  memCacheWidth: 1000,

                  placeholder: (context, url) => Container(
                    height: 350,
                    color: klookSoftGray,
                    child: const Center(
                      child: CircularProgressIndicator(color: klookOrange),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 350,
                    color: klookSoftGray,
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: klookGray,
                    ),
                  ),
                ),

                // --------------------------------------------------
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertyImageGallery(images: property.galleryImageUrls),
                      const SizedBox(height: 24),
                      PropertyHeaderInfo(
                        property: property,
                        primaryColor: klookOrange,
                      ),
                      const SizedBox(height: 24),
                      PropertyStatisticsRow(
                        bedrooms: property.bedrooms,
                        bathrooms: property.bathrooms,
                        kitchen: property.kitchen,
                        backgroundColor: klookBackground,
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        property.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: klookGray,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 24),
                      PropertyReviewSection(controller: reviewController),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (authController.isLoggedIn.value) {
                              final MyKosController myKosController =
                                  Get.find<MyKosController>();

                              myKosController.addMyKos(property);

                              Get.snackbar(
                                'Success',
                                '${property.name} telah ditambahkan ke daftar kos Anda.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green[400],
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16),
                              );

                              Get.off(() => MyTripPage());
                            } else {
                              Get.defaultDialog(
                                title: 'Perlu Login',
                                titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                middleText:
                                    'Anda harus login untuk bisa memesan kos.',
                                textConfirm: 'Login Sekarang',
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.login);
                                },
                                textCancel: 'Batal',
                                onCancel: () {},
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: klookOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const PropertyBackButton(),
        ],
      ),
    );
  }
}

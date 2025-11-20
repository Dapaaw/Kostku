import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; 
import 'package:dio/dio.dart' hide Response;

import '/data/models/kos_model.dart'; 
import '/data/services/api_service.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data KosModel yang dikirim dari MyKosPage
    final KosModel kos = Get.arguments as KosModel;

    // 2. Controller untuk menyimpan state
    final ApiService apiService = ApiService();
    final TextEditingController commentController = TextEditingController();
    final RxDouble rating = 3.0.obs; // Default rating 3 bintang
    final RxBool isLoading = false.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Beri Ulasan'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bagaimana pengalamanmu di',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              kos.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // --- UI Rating Bintang ---
            Text(
              'Rating Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Center(
              child: RatingBar.builder(
                initialRating: rating.value,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false, // Tidak boleh setengah bintang
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) {
                  rating.value = value; // Simpan nilai bintang
                },
              ),
            ),
            const SizedBox(height: 40),

            // --- Field Komentar ---
            Text(
              'Ulasan Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: commentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tulis pengalaman menginap Anda di sini...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Tombol Kirim Ulasan ---
            Obx(() {
              return ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        isLoading.value = true;

                        try {
                          final response = await apiService.addReview(
                            kosId: kos.id,
                            rating: rating.value.toInt(),
                            comment: commentController.text,
                          );

                          if (response.statusCode == 201) {
                            Get.back(result: true); 
                          }
                        } on DioException catch (e) {
                          Get.snackbar(
                            'Gagal',
                            e.response?.data['message'] ??
                                'Gagal mengirim ulasan.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } finally {
                          isLoading.value = false;
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Kirim Ulasan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

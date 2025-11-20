import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/theme.dart';
import '/data/models/review_controller.dart';
import 'review_card.dart';

class PropertyReviewSection extends StatelessWidget {
  final ReviewController controller;

  const PropertyReviewSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ulasan Tamu',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.reviewList.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada ulasan untuk kos ini.',
                style: TextStyle(fontSize: 16, color: klookGray),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.reviewList.length,
            itemBuilder: (context, index) {
              final review = controller.reviewList[index];
              return ReviewCard(review: review);
            },
          );
        }),
      ],
    );
  }
}

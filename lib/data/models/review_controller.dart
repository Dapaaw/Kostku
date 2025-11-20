import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '/data/services/api_service.dart';

class ReviewController extends GetxController {
  final ApiService apiService = ApiService();
  final int kosId;

  ReviewController({required this.kosId});

  var isLoading = true.obs;
  var reviewList = <ReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  void fetchReviews() async {
    try {
      isLoading(true);
      final response = await apiService.getReviewsForKos(kosId);
      if (response.statusCode == 200) {
        reviewList.assignAll(
          (response.data['data'] as List)
              .map((json) => ReviewModel.fromJson(json))
              .toList(),
        );
      }
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
    } finally {
      isLoading(false);
    }
  }
}

// --- MODEL DATA (kita letakkan di sini agar simpel) ---

class ReviewModel {
  final int id;
  final int rating;
  final String comment;
  final String createdAt;
  final ReviewUserModel user;

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['created_at'], // Nanti bisa kita format
      user: ReviewUserModel.fromJson(json['user']),
    );
  }
}

class ReviewUserModel {
  final int id;
  final String fullName;

  ReviewUserModel({required this.id, required this.fullName});

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(id: json['id'], fullName: json['full_name']);
  }
}

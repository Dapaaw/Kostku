import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants.dart';
import '../models/auth_controller.dart';
import '../../routes/app_routes.dart';

class ApiService {
  final Dio _dioPublic = Dio();
  final Dio _dio = Dio();

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          print("DEBUG TOKEN: $token");

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Accept'] = 'application/json';

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.type == DioExceptionType.connectionError ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            Get.snackbar(
              "Connection Error",
              "Tidak dapat terhubung ke server. Silakan periksa koneksi internet Anda.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blueGrey,
              colorText: Colors.white,
              margin: const EdgeInsets.all(16),
            );

            return handler.resolve(
              Response(
                requestOptions: e.requestOptions,
                statusCode: 503,
                data: {'message': 'Tidak ada koneksi internet.'},
              ),
            );
          }

          if (e.response?.statusCode == 401) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
            await prefs.remove('userName');
            await prefs.remove('userEmail');
            final favController = Get.isRegistered<AuthController>()
                ? Get.find<AuthController>()
                : null;
            favController?.loadInitialData();

            Get.snackbar(
              "Session Expired",
              "Silakan login kembali.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFFEF5350),
              colorText: Colors.white,
              margin: const EdgeInsets.all(16),
            );

            Get.offAllNamed(AppRoutes.login);

            return handler.resolve(
              Response(
                requestOptions: e.requestOptions,
                statusCode: 401,
                data: {'message': 'Sesi berakhir, silakan login kembali.'},
              ),
            );
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dioPublic.post(
        "${AppConstants.baseUrl}/login",
        data: {'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dioPublic.post(
        "${AppConstants.baseUrl}/register",
        data: {'full_name': fullName, 'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> logout() async {
    try {
      Response response = await _dio.post("${AppConstants.baseUrl}/logout");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateProfile({
    required String fullName,
    required String email,
  }) async {
    try {
      Response response = await _dio.put(
        "${AppConstants.baseUrl}/user",
        data: {'full_name': fullName, 'email': email},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      Response response = await _dio.put(
        "${AppConstants.baseUrl}/password",
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addReview({
    required int kosId,
    required int rating,
    required String comment,
  }) async {
    try {
      Response response = await _dio.post(
        "${AppConstants.baseUrl}/reviews",
        data: {'kos_id': kosId, 'rating': rating, 'comment': comment},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getReviewsForKos(int kosId) async {
    try {
      Response response = await _dioPublic.get(
        "${AppConstants.baseUrl}/kos/$kosId/reviews",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserProfile() async {
    try {
      Response response = await _dio.get("${AppConstants.baseUrl}/user");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFavorites() async {
    try {
      Response response = await _dio.get("${AppConstants.baseUrl}/favorites");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addFavorite(int kosId) async {
    try {
      Response response = await _dio.post(
        "${AppConstants.baseUrl}/favorites",
        data: {'kos_id': kosId},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> removeFavorite(int kosId) async {
    try {
      Response response = await _dio.delete(
        "${AppConstants.baseUrl}/favorites/$kosId",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllKos({
    String? search,
    String? location,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }
      if (minPrice != null) {
        queryParams['min_price'] = minPrice;
      }
      if (maxPrice != null) {
        queryParams['max_price'] = maxPrice;
      }
      Response response = await _dioPublic.get(
        "${AppConstants.baseUrl}/kos",
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

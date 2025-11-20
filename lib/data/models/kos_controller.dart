import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'kos_model.dart';
import '../services/api_service.dart';

class KosController extends GetxController {
  List<KosModel> filteredTopProperties = [];
  List<KosModel> filteredNearbyProperties = [];
  final List<String> locations = [
    'Semua Lokasi',
    'Lowokwaru',
    'Sukun',
    'Pakis',
    'Blimbing',
  ];
  String selectedLocation = 'Semua Lokasi';
  final List<String> priceRanges = [
    'Semua Harga',
    'Rp 0 - Rp 700.000',
    'Rp 700.000 - Rp 1.100.000',
    'Rp 1.200.000 - Rp 1.500.000',
    'Rp 1.500.000 - Rp 2.600.000',
  ];
  String selectedPriceRange = 'Semua Harga';
  String searchQuery = '';

  final ApiService apiServices = ApiService();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKosFromApi();
  }

  void updatePriceRange(String newRange) {
    selectedPriceRange = newRange;
    fetchKosFromApi();
  }

  void updateLocation(String? newLocation) {
    if (newLocation == null) return;
    selectedLocation = newLocation;
    fetchKosFromApi();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    fetchKosFromApi();
  }

  (double, double) _parsePriceRange(String range) {
    if (range == 'Semua Harga') {
      return (0, double.infinity);
    }
    range = range.replaceAll('Rp ', '').replaceAll('.', '');
    final parts = range.split(' - ');
    if (parts.length != 2) {
      return (0, double.infinity);
    }
    final minParsed = double.tryParse(parts[0].replaceAll('.', '')) ?? 0;
    final maxParsed =
        double.tryParse(parts[1].replaceAll('.', '')) ?? double.infinity;
    return (minParsed, maxParsed);
  }

  // --- FUNGSI FETCH (Sedikit diubah) ---
  void fetchKosFromApi() async {
    try {
      isLoading(true);
      errorMessage('');

      final (double minPrice, double maxPrice) = _parsePriceRange(
        selectedPriceRange,
      );
      
      String? locationToSend = selectedLocation == 'Semua Lokasi' ? null : selectedLocation;
      
      final response = await apiServices.getAllKos(
        search: searchQuery.isEmpty ? null : searchQuery,
        location: locationToSend,
        minPrice: minPrice == 0 ? null : minPrice,
        maxPrice: maxPrice == double.infinity ? null : maxPrice,
      );
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data['data'];
        final List<KosModel> filteredResults = result
            .map((json) => KosModel.fromJson(json as Map<String, dynamic>))
            .toList();

        filteredTopProperties = filteredResults;

        filteredNearbyProperties = filteredResults;
      } else {
        errorMessage('Gagal mengambil data dari server.');
      }
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      debugPrint('Response: ${e.response?.data}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      
      if (e.response?.statusCode == 500) {
        errorMessage('Server error. Periksa backend Laravel.');
      } else if (e.response?.statusCode == 404) {
        errorMessage('Endpoint tidak ditemukan.');
      } else {
        errorMessage('Terjadi error koneksi: ${e.message}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      errorMessage('Terjadi error tidak diketahui: $e');
    } finally {
      isLoading(false);
    }
  }
}

import 'package:get/get.dart';
import 'kos_model.dart';

class KosController extends GetxController {
  List<KosModel> allTopProperties = [];
  List<KosModel> allNearbyProperties = [];
  List<KosModel> filteredTopProperties = [];
  List<KosModel> filteredNearbyProperties = [];
  final List<String> locations = [
    'Semua Lokasi',
    'Lowokwaru',
    'Sukun',
    'Klojen',
    'Blimbing',
  ];
  String selectedLocation = 'Semua Lokasi';
  final List<String> priceRanges = [
    'Semua Harga',
    'Rp 450.000 - Rp 1.000.000',
    'Rp 1.100.000 - Rp 1.500.000',
    'Rp 1.600.000 - Rp 2.000.000',
    'Rp 2.100.000 - Rp 3.000.000',
  ];
  String selectedPriceRange = 'Semua Harga';
  String searchQuery = ''; // Variabel baru untuk menampung teks pencarian

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
    _applyPriceFilter();
    _applyLocationFilter();
  }
  void updatePriceRange(String newRange) {
    selectedPriceRange = newRange;
    _applyPriceFilter(); // Panggil filter harga
  }
  void updateLocation(String? newLocation) {
    if (newLocation == null) return;
    selectedLocation = newLocation;
    _applyLocationFilter(); // Panggil filter lokasi
  }
  void updateSearchQuery(String query) {
    searchQuery = query;
    _applyPriceFilter();
    _applyLocationFilter();
  }
  void _applyPriceFilter() {
    final (double minPrice, double maxPrice) = _parsePriceRange(
      selectedPriceRange,
    );

    filteredTopProperties = allTopProperties.where((kos) {
      final bool priceMatch = (kos.price >= minPrice && kos.price <= maxPrice);
      final bool nameMatch = searchQuery.isEmpty
          ? true // Jika search kosong, loloskan semua
          : kos.name.toLowerCase().contains(searchQuery.toLowerCase());

      return priceMatch && nameMatch; // <-- Harus lolos keduanya
    }).toList();

    update(); // Beri tahu GetBuilder
  }
  void _applyLocationFilter() {
    final String currentLocation = selectedLocation;

    filteredNearbyProperties = allNearbyProperties.where((kos) {
      final bool locationMatch =
          (currentLocation == 'Semua Lokasi') ||
          (kos.location.toLowerCase() == currentLocation.toLowerCase());
      final bool nameMatch = searchQuery.isEmpty
          ? true // Jika search kosong, loloskan semua
          : kos.name.toLowerCase().contains(searchQuery.toLowerCase());

      return locationMatch && nameMatch; // <-- Harus lolos keduanya
    }).toList();

    update(); // Beri tahu GetBuilder
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
  void _loadDummyData() {
    allTopProperties = [
      KosModel(
        id: 1,
        name: 'Gardenia Prime',
        location: 'Sukun',
        price: 1200000,
        imageUrl:
            'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        rating: 4.5,
      ),
      KosModel(
        id: 2,
        name: 'Sansivera',
        location: 'Lowokwaru',
        price: 1650000,
        imageUrl:
            'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        rating: 4.6,
      ),
      KosModel(
        id: 9,
        name: 'Kos Elit Blimbing',
        location: 'Blimbing',
        price: 2500000,
        imageUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400',
        rating: 4.8,
      ),
    ];
    allNearbyProperties = [
      KosModel(
        id: 3,
        name: 'PutriBungah',
        location: 'Klojen',
        price: 475000,
        imageUrl:
            'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        rating: 4.3,
      ),
      KosModel(
        id: 4,
        name: 'Perum Bestari Indah',
        location: 'Sukun',
        price: 550000,
        imageUrl:
            'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=400',
        rating: 4.4,
      ),
      KosModel(
        id: 5,
        name: 'Kos Pak Budi',
        location: 'Lowokwaru',
        price: 800000,
        imageUrl:
            'https://images.unsplash.com/photo-1494526585095-c41746248156?w=400',
        rating: 4.2,
      ),
      KosModel(
        id: 6,
        name: 'Griya Asri Sukun',
        location: 'Sukun',
        price: 900000,
        imageUrl:
            'https://images.unsplash.com/photo-1570129477490-d1162b7e3e76?w=400',
        rating: 4.1,
      ),
      KosModel(
        id: 7,
        name: 'Kos Ceria Lowokwaru',
        location: 'Lowokwaru',
        price: 650000,
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400',
        rating: 4.0,
      ),
      KosModel(
        id: 8,
        name: 'Wisma Pelajar Sukun',
        location: 'Sukun',
        price: 750000,
        imageUrl:
            'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=400',
        rating: 4.3,
      ),
    ];
  }
}

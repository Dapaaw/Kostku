import 'package:get/get.dart';
import 'package:hotel/data/models/hotel_model.dart'; 

class FavoriteController extends GetxController {
  List<HotelModel> favoriteList = [];

  void toggleFavorite(HotelModel hotel) {
    if (isFavorite(hotel.id)) {
      favoriteList.removeWhere((item) => item.id == hotel.id);
    } else {
      favoriteList.add(hotel);
    }
    
    update(); 
  }

  bool isFavorite(int hotelId) {
    return favoriteList.any((item) => item.id == hotelId);
  }
}
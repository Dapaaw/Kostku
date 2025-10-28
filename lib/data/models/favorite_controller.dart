import 'package:get/get.dart';
import 'package:hotel/data/models/kos_model.dart'; 

class FavoriteController extends GetxController {
  List<KosModel> favoriteList = [];

  void toggleFavorite(KosModel hotel) {
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
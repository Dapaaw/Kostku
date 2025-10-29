import 'package:get/get.dart';
import '../models/kos_model.dart'; 

class FavoriteController extends GetxController {
  List<KosModel> favoriteList = [];

  void toggleFavorite(KosModel kos) {
    if (isFavorite(kos.id)) {
      favoriteList.removeWhere((item) => item.id == kos.id);
    } else {
      favoriteList.add(kos);
    }
    
    update(); 
  }

  bool isFavorite(int kosId) {
    return favoriteList.any((item) => item.id == kosId);
  }
}
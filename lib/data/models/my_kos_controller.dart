import 'package:get/get.dart';
import 'kos_model.dart';

class MyKosController extends GetxController {
  // --- PERBAIKAN 1: Gunakan var atau RxList ---
  // Jangan pakai List<KosModel>, karena itu mematikan fitur .obs
  var myKosList = <KosModel>[].obs;

  void addMyKos(KosModel kos) {
    if (!isBooked(kos.id)) {
      myKosList.add(kos);
      // update(); <--- Hapus ini, tidak perlu lagi karena sudah pakai .obs
    }
  }

  bool isBooked(int kosId) {
    return myKosList.any((item) => item.id == kosId);
  }

  void removeMyKos(int kosId) {
    myKosList.removeWhere((item) => item.id == kosId);
    // update(); <--- Hapus ini juga
  }
}

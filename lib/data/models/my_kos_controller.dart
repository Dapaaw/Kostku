import 'package:get/get.dart';
import '../models/kos_model.dart';

class MyKosController extends GetxController {
  final RxList<KosModel> myKosList = <KosModel>[].obs;

  void addMyKos(KosModel kos) {
    if (!isBooked(kos.id)) {
      myKosList.add(kos);
    }
  }

  bool isBooked(int kosId) {
    return myKosList.any((item) => item.id == kosId);
  }

  void removeMyKos(int kosId) {
    myKosList.removeWhere((item) => item.id == kosId);
  }
}

import 'package:get/get.dart';
import 'kos_model.dart';

class MyKosController extends GetxController {
  List<KosModel> myKosList = <KosModel>[];

  void addMyKos(KosModel kos) {
    if (!isBooked(kos.id)) {
      myKosList.add(kos);
      update();
    }
  }

  bool isBooked(int kosId) {
    return myKosList.any((item) => item.id == kosId);
  }

  void removeMyKos(int kosId) {
    myKosList.removeWhere((item) => item.id == kosId);
    update();
  }
}

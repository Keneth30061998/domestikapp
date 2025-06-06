import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class HomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('client') ?? {}); //pasar datos

  HomeController() {
    print('USUARIO DE SESION: ${user.toJson()}');
  }

  void signOut(){
    GetStorage().remove('client');
    Get.offNamedUntil('/', (route) => false); //elimina todo el historial de pantallas
  }
}

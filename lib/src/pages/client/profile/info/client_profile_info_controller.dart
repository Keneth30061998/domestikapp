import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/user.dart';

class ClientProfileInfoController extends GetxController {
  var user = User.fromJson(GetStorage().read('user')).obs;

  //Metodo para cerrar sesion
  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false);
  }

  //Metodo para ir al formulario de actualizar datos
  void goToProfileUpdate() {
    Get.toNamed('/client/profile/update');
  }
}

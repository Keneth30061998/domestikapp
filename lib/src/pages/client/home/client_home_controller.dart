import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientHomeController extends GetxController {

  /// Controlador para manejar el `PageView`
  final PageController pageController = PageController(initialPage: 0);

  /// Controlador para manejar el `AnimatedNotchBottomBar`
  final NotchBottomBarController bottomBarController = NotchBottomBarController(index: 0);

  /// Función para manejar el cambio de página
  void onBottomBarTap(int index) {
    pageController.jumpToPage(index);
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}

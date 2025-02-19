import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/home/client_home_controller.dart';
import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_page.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    /// Lista de páginas para el `PageView`
    final List<Widget> pages = [
      ClientServicesListPage(),
      Center(
          child:
              Text('Página 3: Configuración', style: TextStyle(fontSize: 20))),
      ClientProfileInfoPage(),
    ];

    return Scaffold(
      body: PageView(
        controller: con.pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Desactiva el deslizamiento manual
        children: pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        bottomBarHeight: 80,
        notchBottomBarController: con.bottomBarController,
        color: color_primary,
        notchColor: color_notch,
        showLabel: true,
        itemLabelStyle: const TextStyle(fontSize: 12),
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.list,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.list,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Servicio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Servicio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onTap: con.onBottomBarTap,
        kIconSize: 28.0,
        kBottomRadius: 28,
      ),
    );
  }
}

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:domestik_app/src/pages/premises/categories/create/premises_categories_create_page.dart';
import 'package:domestik_app/src/pages/premises/home/premises_home_controller.dart';
import 'package:domestik_app/src/pages/premises/orders/list/premises_orders_list_page.dart';
import 'package:domestik_app/src/pages/premises/services/create/premises_services_create_page.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremisesHomePage extends StatelessWidget {
  PremisesHomeController con = Get.put(PremisesHomeController());

  @override
  Widget build(BuildContext context) {
    /// Lista de páginas para el `PageView`
    final List<Widget> pages = [
      PremisesOrdersListPage(),
      PremisesCategoriesCreatePage(),
      PremisesServicesCreatePage(),
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
        bottomBarWidth: 550,
        notchBottomBarController: con.bottomBarController,
        color: color_primary,
        notchColor: color_notch,
        showLabel: true,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.list,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.list_outlined,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Pedidos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.category,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.category_outlined,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Categoria',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.engineering,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.engineering_outlined,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Servicio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
            activeItem: Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 26,
            ),
            itemLabelWidget: Text(
              'Perfil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
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

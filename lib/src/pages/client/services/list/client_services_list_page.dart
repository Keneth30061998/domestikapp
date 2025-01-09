import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientServicesListPage extends StatelessWidget {
  ClientServicesListController con = Get.put(ClientServicesListController());

  Widget build(BuildContext context) {
    /// Lista de páginas para el `PageView`
    final List<Widget> pages = [
      Center(child: Text('Página 1: Servicios', style: TextStyle(fontSize: 20))),
      Center(child: Text('Página 2: Favoritos', style: TextStyle(fontSize: 20))),
      Center(child: Text('Página 3: Configuración', style: TextStyle(fontSize: 20))),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Client Services List Page'),
        backgroundColor: color_primary,
        foregroundColor: background_form,
      ),
      body: PageView(
        controller: con.pageController,
        physics: const NeverScrollableScrollPhysics(), // Desactiva el deslizamiento manual
        children: pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: con.bottomBarController,
        color: color_primary,
        notchColor: color_notch,
        showLabel: true,
        itemLabelStyle: const TextStyle(fontSize: 12),
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.list, color: Colors.white, size: 28,),
            activeItem: Icon(Icons.list, color: Colors.white,size: 26,),
            itemLabelWidget: Text('Servicios',style: TextStyle(color: Colors.white),),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.favorite, color: Colors.white,size: 28,),
            activeItem: Icon(Icons.favorite, color: Colors.white,size: 26,),
            itemLabelWidget: Text('Servicios',style: TextStyle(color: Colors.white),),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.settings, color: Colors.white,size: 28,),
            activeItem: Icon(Icons.settings, color: Colors.white,size: 26,),
            itemLabelWidget: Text('Servicios',style: TextStyle(color: Colors.white),),
          ),
        ],
        onTap: con.onBottomBarTap,
        kIconSize: 24.0, kBottomRadius: 28,
      ),
    );
  }

}

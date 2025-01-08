import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientServicesListPage extends StatelessWidget {
  ClientServicesListController con = Get.put(ClientServicesListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Client Services List Page'),
            ElevatedButton(
              onPressed: con.signOut,
              child: Text('Cerrar sesion'),
            )
          ],
        ),
      ),
    );
  }
}

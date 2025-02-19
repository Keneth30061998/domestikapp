import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientServicesListPage extends StatelessWidget {
  ClientServicesListController con = Get.put(ClientServicesListController());

  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Center(
        child: Text('Client Services List'),
      ),
    );
  }
}

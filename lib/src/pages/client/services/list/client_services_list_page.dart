import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/category.dart';

class ClientServicesListPage extends StatelessWidget {
  ClientServicesListController con = Get.put(ClientServicesListController());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            bottom: TabBar(
              indicatorColor: color_primary,
              labelColor: color_primary,
              unselectedLabelColor: Colors.grey[400],
              tabs: List<Widget>.generate(con.categories.length, (index) {
                return Tab(
                  child: Text(con.categories[index].name ?? ''),
                );
              }),
              isScrollable: true,
            ),
          ),
        ),
        body: TabBarView(
          children: con.categories.map((Category category) {
            return Container();
          }).toList(),
        ),
      ),
    );
  }
}

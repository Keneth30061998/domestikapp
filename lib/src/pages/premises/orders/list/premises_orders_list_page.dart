import 'package:domestik_app/src/pages/premises/orders/list/premises_orders_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremisesOrdersListPage extends StatelessWidget {
  PremisesOrdersListController con = Get.put(PremisesOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Premises Orders List'),
      ),
    );
  }
}

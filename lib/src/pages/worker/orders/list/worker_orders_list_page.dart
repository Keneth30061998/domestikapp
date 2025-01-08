import 'package:domestik_app/src/pages/worker/orders/list/worker_orders_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerOrdersListPage extends StatelessWidget {
  WorkerOrdersListController con = Get.put(WorkerOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Worker Orders List Page'),
      ),
    );
  }
}

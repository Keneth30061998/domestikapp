import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/pages/client/services/detail/client_services_detail_page.dart';
import 'package:domestik_app/src/providers/categories_provider.dart';
import 'package:domestik_app/src/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../models/service.dart';

class ClientServicesListController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ServicesProviders servicesProviders = ServicesProviders();

  List<Category> categories = <Category>[].obs;

  ClientServicesListController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  //Para Listar los productos segun su categoria
  Future<List<Service>> getServices(String idCategory) async {
    return await servicesProviders.findByCategory(idCategory);
  }

  //Para el modal bottom sheet -> detalle del servicio
  void openBottomSheet(Service service, BuildContext context) {
    showMaterialModalBottomSheet(context: context, builder: (context)=> ClientServicesDetailPage(service: service,));
  }
}

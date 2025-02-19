import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/models/response_api.dart';
import 'package:domestik_app/src/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremisesCategoriesCreateController extends GetxController {
  //controlladores para los textinput de la page.
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //Provider de las categories
  CategoriesProvider categoriesProvider = CategoriesProvider();

  //Metodo para crear una categoria
  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      //usar el modelo para eniar datos
      Category category = Category(name: name, description: description);
      //lanzamos la peticion
      ResponseApi responseApi = await categoriesProvider.create(category);

      Get.snackbar('Proceso Terminado',
          'Categoria creada correctamente: ${responseApi.message}');

      //Para limpiar el formulario
      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Error en el registro de Categoria', 'Campos vacíos');
    }
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}

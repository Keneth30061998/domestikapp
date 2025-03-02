import 'dart:convert';
import 'dart:io';

import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/models/response_api.dart';
import 'package:domestik_app/src/providers/categories_provider.dart';
import 'package:domestik_app/src/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../models/service.dart';

class PremisesServicesCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  //Para listar las categorias
  var idCategory = ''.obs;
  List<Category> categories = <Category>[].obs;

  //Para registrar un servicio
  ServicesProviders servicesProviders = ServicesProviders();

  //Constructor de la clase
  PremisesServicesCreateController() {
    getCategories();
  }

  //Metodo para listar categorias
  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  //Metodo para crear un Service
  void createService(BuildContext context) async {
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    print('Name: ${name}');
    print('Precio: ${price}');
    print('Descripcion: ${description}');

    //Progress -> distractor
    ProgressDialog progressDialog = ProgressDialog(context: context);
    //Validacion de campos vacios
    if (isValidForm(name, description, price)) {
      Service service = Service(
          name: name,
          description: description,
          price: double.parse(price),
          idCategory: idCategory.value);
      progressDialog.show(max: 100, msg: 'Registrando el servicio...');

      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);

      Stream stream = await servicesProviders.create(service, images);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso Terminado', responseApi.message ?? '');
        if (responseApi.success == true) {
          clear();
        }
      });
    }
  }

  //Meetodo de validacion de campos del form de Servicio
  bool isValidForm(String name, String description, String price) {
    if (name.isEmpty) {
      Get.snackbar('Campo Nombre vacío', 'Ingrese un nombre de servicio');
      return false;
    }
    if (description.isEmpty) {
      Get.snackbar('Campo Descripción vacío',
          'Ingrese una descripcion para el servicio');
      return false;
    }
    if (price.isEmpty) {
      Get.snackbar('Campo Precio vacío', 'Ingrese un precio para el servicio');
      return false;
    }
    if (idCategory.value == '') {
      Get.snackbar(
          'Formulario no válido', 'Seleccione la categoria del servicio');
      return false;
    }
    if (imageFile1 == null) {
      Get.snackbar('Formulario no válido', 'Seleccione imagen 1');
      return false;
    }
    if (imageFile2 == null) {
      Get.snackbar('Formulario no válido', 'Seleccione imagen 2');
      return false;
    }
    if (imageFile3 == null) {
      Get.snackbar('Formulario no válido', 'Seleccione imagen 3');
      return false;
    }
    return true;
  }

  //Metodos que nos permitian seleccionar imagenes
  //uso de image - picker
  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery, numberFile);
      },
      child: Text('Galeria'),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera, numberFile);
      },
      child: Text('Cámara'),
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  //Funcionalidades para escoger imagenes
  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      }
      if (numberFile == 2) {
        imageFile2 = File(image.path);
      }
      if (numberFile == 3) {
        imageFile3 = File(image.path);
      }
      update();
    }
  }

  //Metodo para limpiar los campos del formulario
  void clear() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }
}

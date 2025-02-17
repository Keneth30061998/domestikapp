import 'dart:convert';
import 'dart:io';

import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:domestik_app/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../models/response_api.dart';
import '../../../../models/user.dart';

class ClientProfileUpdateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //Providers: actualizacion de usuario
  UsersProvider usersProvider = UsersProvider();

  //instancias necesarias para escoger imagenes
  ImagePicker picker = ImagePicker();
  File? imageFile;

  //Llamamos al controllador del profile info - actualizr los datos en pantalla
  ClientProfileInfoController clientProfileInfoController = Get.find();

  //Cargamos los datos del usuaurio registrado mediante el constructor
  ClientProfileUpdateController() {
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  //uso de image - picker
  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria'),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
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
      },
    );
  }

  //Validacion de campos para enviar la actualizacion

  bool isValidForm(
    String name,
    String lastname,
    String phone,
  ) {
    /**Verificar valides de los campos -> usando GetX */
    if (!GetUtils.isUsername(name)) {
      Get.snackbar('Nombre incorrecto', 'Ingrese un nombre válido');
      return false;
    }
    if (!GetUtils.isUsername(lastname)) {
      Get.snackbar('Apellido incorrecto', 'Ingrese un apellido válido');
      return false;
    }
    if (!GetUtils.isPhoneNumber(phone)) {
      Get.snackbar('Teléfono incorrecto', 'Ingrese un teléfono válido');
      return false;
    }
    /**Verificar campos vacios */

    if (name.isEmpty) {
      Get.snackbar('Nombre Vacío', 'Ingrese su nombre');
      return false;
    }
    if (lastname.isEmpty) {
      Get.snackbar('Apellido Vacío', 'Ingrese su apellido');
      return false;
    }
    if (phone.isEmpty) {
      Get.snackbar('Teléfono Vacío', 'Ingrese un teléfono');
      return false;
    }

    return true;
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    /**llamado al metodo de validacion */
    if (isValidForm(name, lastname, phone)) {
      //Para añadir un progressDialog
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 75, msg: "Actualizando Datos...");

      //Para realizar el resgistro
      User myUser = User(
          //diferenciar el usuario que viene de la bd del actualizado
          id: user.id,
          name: name,
          lastname: lastname,
          phone: phone,
          sessionToken: user.sessionToken);
      if (imageFile == null) {
        //Funcionalidad para actualizar sin imagen
        ResponseApi responseApi = await usersProvider.update(myUser);
        print('Response Api Update: ${responseApi.data}');
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value = User.fromJson(responseApi.data);
          progressDialog.close();
        }
      } else {
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          print('Response Api Update: ${responseApi.data}');
          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            clientProfileInfoController.user.value = User.fromJson(responseApi.data);
          } else {
            Get.snackbar('Error', 'Error en el registro de usuario');
          }
        });
      }
    }
  }

  //Funcionalidades para escoger imagenes
  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:domestik_app/src/models/response_api.dart';
import 'package:domestik_app/src/models/user.dart';
import 'package:domestik_app/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  //instancias necesarias para escoger imagenes
  ImagePicker picker = ImagePicker();
  File? imageFile;

  /**Metodo que permite el registro */
  void registrar(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    /**llamado al metodo de validacion */
    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {

      //Para añadir un progressDialog
      ProgressDialog  progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 75,msg: "Registrando Datos...");

      //Para realizar el resgistro
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      //Response response = await usersProvider.create(client);
      //print('Response: ${response.body}');

      //Get.snackbar('Datos Válidos', 'Registro de usuario...');
      //print('Email: ${email}');
      //print('Nombre: ${name}');
      //print('Password: ${password}');

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res){

        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.success==true){
          GetStorage().write('user', responseApi.data);
          goToHomePage();
        }else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }

  /** Método para navegar al home despues del registro */
  void goToHomePage(){
    Get.offNamedUntil('/client/services/list', (route)=>false);
  }

  /**Metodo de validacion para los textEdit */
  bool isValidForm(
    String email,
    String name,
    String lastname,
    String phone,
    String password,
    String confirmPassword,
  ) {
    /**Verificar valides de los campos -> usando GetX */
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Email incorrecto', 'Ingrese un email válido');
      return false;
    }
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
    if (email.isEmpty) {
      Get.snackbar('Email Vacío', 'Ingrese un email');
      return false;
    }
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
    if (password.isEmpty) {
      Get.snackbar('Contraseña Vacía', 'Ingrese una contraseña');
      return false;
    }
    if (confirmPassword.isEmpty) {
      Get.snackbar('Confirmacion de contraseña Vacía',
          'Ingrese la confirmación de contraseña');
      return false;
    }
    if (password != confirmPassword) {
      Get.snackbar('Contraseñas no coinciden',
          'Revise las contraseñas e intente de nuevo');
      return false;
    }

    if(imageFile==null){
      Get.snackbar('Formulario no válido', "Debe registrar una imágen");
      return false;
    }

    return true;
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
        });
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

import 'package:domestik_app/src/providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/response_api.dart';

class LoginController extends GetxController {
  //**Capturar valores de los campos que ingrese el usuario */
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider(); //Necesario para obtener las funciones del provider

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  //**Metodo Login que permita verificar si el usuario esta registrado */
  void Login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (isValidForm(email, password)) {

      ResponseApi responseApi = await usersProvider.login(email, password);

      //** Mensajes guias : impresion de respuesta de la Api + Validaciones + Campos(email - password)*/
      print('Response Api: ${responseApi.toJson()}');
      Get.snackbar('Datos Válidos', 'Inicio de sesion...');
      print('Email: ${email}');
      print('Password: ${password}');

      //validaciones
      if(responseApi.success == true){
        Get.snackbar('Login Exitoso', 'Ingresando a la cuenta...');

        GetStorage().write('user', responseApi.data); //Para almacenar la data devuelta

        goToHomePage();

      }else{
        Get.snackbar('Login Fallido', responseApi.message ?? '');//otra forma de enviar el mensaje
      }

    }
  }

  /** Funcion para movernos a Home*/
  void goToHomePage(){
    Get.toNamed('/home');
  }

  /**Funcion de validacion */
  bool isValidForm(String email, String password) {
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Email Incorecto', 'Ingrese un email válido');
      return false;
    }

    if (email.isEmpty) {
      Get.snackbar('Email Vacío', 'Ingrese un email válido');
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar('Password Vacío', 'Ingrese una constraseña válida');
      return false;
    }
    return true;
  }
}

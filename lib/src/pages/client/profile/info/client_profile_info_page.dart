import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color.dart';
import 'client_profile_info_controller.dart';

class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _buttonClose(),
          ],
        ),
      ),
    );
  }

  //Widgets Personalizados
  //** Fondo azul **
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        color: color_primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  //** Box Form **

  Widget _boxForm(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.10,
            left: 30,
            right: 30,
            bottom: 20),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: background_form,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                offset: Offset(0, 0.5),
              )
            ]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textTitle(),
              _imageUser(context),
              _textNameLastname(),
              _textEmail(),
              _textPhone(),
              _buttonUpdate(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Imagen de usuario
  Widget _imageUser(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundImage: con.user.value.image != null
            ? NetworkImage(con.user.value.image!)
            : AssetImage('assets/img/usuario.png') as ImageProvider,
        radius: 60,
        backgroundColor: color_text,
      ),
    );
  }

  //widget de titulo
  Widget _textTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        "Perfil de Usuario",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: color_primary),
      ),
    );
  }

  //widget de texto:  nombre + apellido
  Widget _textNameLastname() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}',
        style: TextStyle(
            color: color_primary,
            fontSize: 23,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  //widget de texto: email
  Widget _textEmail() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.mail),
        title: Text(
          con.user.value.email ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Email'),
      ),
    );
  }

  //widget de texto: email
  Widget _textPhone() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        leading: Icon(Icons.phone),
        title: Text(
          con.user.value.phone ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Phone'),
      ),
    );
  }

  // Boton de cerrar sesion
  Widget _buttonClose() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 20, top: 10),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.signOut(),
          icon: Icon(
            Icons.power_settings_new_rounded,
            color: color_secondary,
            size: 30,
          ),
        ),
      ),
    );
  }

  //Boton Editar perfil de usuario
  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton.tonalIcon(
        onPressed: () => con.goToProfileUpdate(),
        label: Text('Actualizar'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color_primary),
          foregroundColor: MaterialStateProperty.all(background_form),
        ),
        icon: Icon(
          Icons.update,
          color: background_form,
        ),
      ),
    );
  }
}

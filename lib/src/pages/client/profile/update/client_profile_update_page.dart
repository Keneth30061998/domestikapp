import 'package:domestik_app/src/pages/client/profile/update/client_profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
        ],
      ),
    );
  }

  //Widgets Personalizados
  //** Fondo azul **
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.33,
      decoration: BoxDecoration(
        color: color_primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }

  //** Box Form **

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.64,
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.16, left: 30, right: 30),
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
            _textSubtitle(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _buttonUpdate(context),
          ],
        ),
      ),
    );
  }

  /// Imagen de usuario
  Widget _imageUser(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            return con.showAlertDialog(context);
          },
          child: GetBuilder<ClientProfileUpdateController>(
            builder: (value) => CircleAvatar(
              backgroundImage: con.imageFile != null
                  ? FileImage(con.imageFile!)
                  : con.user.image != null
                      ? NetworkImage(con.user.image!)
                      : AssetImage('assets/img/usuario.png') as ImageProvider,
              radius: 60,
              backgroundColor: color_text,
            ),
          )),
    );
  }

  //Widget dentro de boxForm

  Widget _textTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        "Datos de Usuario",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: color_primary),
      ),
    );
  }

  Widget _textSubtitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        "Actualiza información",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: color_primary),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: color_secondary),
          labelText: "Nombre",
          hintText: "Nombre",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: color_secondary),
          labelText: "Apellido",
          hintText: "Apellido",
          prefixIcon: Icon(Icons.person_2_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: color_secondary),
          labelText: "Teléfono",
          hintText: "Teléfono",
          prefixIcon: Icon(Icons.call),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color_secondary),
          ),
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton(
        onPressed: () => con.updateInfo(context),
        child: Text('Actualizar'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color_primary), //
        ),
      ),
    );
  }
}

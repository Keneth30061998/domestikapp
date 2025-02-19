import 'package:domestik_app/src/pages/premises/categories/create/premises_categories_create_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PremisesCategoriesCreatePage extends StatelessWidget {
  //controladores
  PremisesCategoriesCreateController con =
      Get.put(PremisesCategoriesCreateController());

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
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.20, left: 30, right: 30),
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
            _textSubtitle(),
            _textFieldName(),
            _textFieldDescription(),
            _buttonCreate(context),
          ],
        ),
      ),
    );
  }

  //Widget dentro de boxForm

  Widget _textTitle() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        children: [
          Text(
            "Crear nueva categoría",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: color_primary,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.list_alt,
            size: 70,
          )
        ],
      ),
    );
  }

  Widget _textSubtitle() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      child: Text(
        "Ingrese los datos",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20, color: color_primary),
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

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.name,
        maxLines: 3,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: color_secondary),
          labelText: "Descripción",
          hintText: "Descripción",
          prefixIcon: Icon(Icons.description),
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

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton.tonalIcon(
        onPressed: () {
          con.createCategory();
        },
        label: Text('Crear'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color_primary),
            foregroundColor:
                MaterialStateProperty.all(background_elevatedButton) //
            ),
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}

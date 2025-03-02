import 'dart:io';

import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/pages/premises/services/create/premises_services_create_controller.dart';
import 'package:domestik_app/src/pages/register/register_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PremisesServicesCreatePage extends StatelessWidget {
  PremisesServicesCreateController con =
      Get.put(PremisesServicesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
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
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }

  //** Box Form **

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15, left: 30, right: 30),
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
            _textFieldPrice(),
            _textFieldDescription(),
            _dropDownCategories(con.categories),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<PremisesServicesCreateController>(
                      builder: (value) =>
                          _cardImage(con.imageFile1, 1, context)),
                  GetBuilder<PremisesServicesCreateController>(
                      builder: (value) =>
                          _cardImage(con.imageFile2, 2, context)),
                  GetBuilder<PremisesServicesCreateController>(
                      builder: (value) =>
                          _cardImage(con.imageFile3, 3, context)),
                ],
              ),
            ),
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
            "Registro de servicio",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: color_primary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Icon(
            Icons.interests,
            size: 90,
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

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: color_secondary),
            labelText: 'Precio',
            hintText: 'Precio',
            prefixIcon: Icon(Icons.monetization_on),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color_secondary),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: color_secondary))),
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
          con.createService(context);
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

  Widget _cardImage(File? imageFile, int numberFile, BuildContext context) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context, numberFile),
      child: Card(
        elevation: 2,
        child: Container(
            color: Colors.transparent,
            height: 100,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(3),
            child: imageFile != null
                ? Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/img/subir.png')),
      ),
    );
  }

  //Para Listar categorias
  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });
    return list;
  }

  //Widget para listar
  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: color_primary,
          ),
        ),
        elevation: 2,
        isExpanded: true,
        hint: Text(
          'Categoria',
          style: TextStyle(
            color: color_primary,
            fontSize: 16,
          ),
        ),
        items: _dropDownItems(categories),
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          con.idCategory.value = option.toString();
        },
      ),
    );
  }
}

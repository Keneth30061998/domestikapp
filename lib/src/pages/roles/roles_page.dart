import 'package:domestik_app/src/pages/roles/roles_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:domestik_app/src/models/rol.dart';
import 'package:get/get.dart';

class RolesPage extends StatelessWidget {
  RolesController con = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Rol"),
        backgroundColor: color_secondary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.15),
        child: ListView(
          children: con.user.roles != null
              ? con.user.roles!.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: ()=>con.goToPageRol(rol),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: 100,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/noImage.jpg'),
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeOutDuration: const Duration(milliseconds: 50),
            ),
          ),
          Text(
            rol.name ?? '',
            style: TextStyle(
              fontSize: 20,
              color: color_primary
            ),
          )
        ],
      ),
    );
  }
}

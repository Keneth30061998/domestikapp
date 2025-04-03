import 'package:domestik_app/src/models/service.dart';
import 'package:domestik_app/src/pages/client/services/detail/client_services_detail_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ClientServicesDetailPage extends StatelessWidget {
  ClientServicesDetailController con =
      Get.put(ClientServicesDetailController());

  //Para listar los servicios -> carrusel
  Service? service;

  //Constructor -> necesario para cargar los datos del servicio
  ClientServicesDetailPage({@required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _imageSlideShow(context),
          _textTitle(),
          _textDescription(),
        ],
      ),
      bottomNavigationBar: _priceCard(context),
    );
  }

  //Widget para el carrusel de imagenes
  Widget _imageSlideShow(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
            height: MediaQuery.of(context).size.height * 0.4,
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 20),
                placeholder: AssetImage('assets/img/noImage.jpg'),
                image: service!.image1 != null
                    ? NetworkImage(service!.image1!)
                    : AssetImage('assets/img/noImage.jpg') as ImageProvider,
              ),
              FadeInImage(
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 20),
                placeholder: AssetImage('assets/img/noImage.jpg'),
                image: service!.image2 != null
                    ? NetworkImage(service!.image2!)
                    : AssetImage('assets/img/noImage.jpg') as ImageProvider,
              ),
              FadeInImage(
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 20),
                placeholder: AssetImage('assets/img/noImage.jpg'),
                image: service!.image3 != null
                    ? NetworkImage(service!.image3!)
                    : AssetImage('assets/img/noImage.jpg') as ImageProvider,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Widgets para titulos y descripcion
  Widget _textTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Text(
        service?.name ?? '',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color_primary,
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        service?.description ?? '',
        style: TextStyle(
          fontSize: 18,
          color: color_primary,
        ),
      ),
    );
  }

  Widget _priceCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: background_form,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$ ${service?.price.toString() ?? '0.00'}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color_primary,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(':)');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color_primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                "Reservar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

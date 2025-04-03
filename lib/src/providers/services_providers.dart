import 'dart:convert';
import 'dart:io';

import 'package:domestik_app/src/environment/environment.dart';
import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/models/service.dart';
import 'package:domestik_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ServicesProviders extends GetConnect {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  //Importante llamar directamente la url
  String url = Environment.API_URL + 'api/services';

  Future<Stream> create(Service service, List<File> images) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/services/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for (int i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(images[i].openRead().cast()),
        await images[i].length(),
        filename: basename(images[i].path),
      ));
    }
    request.fields['service'] = json.encode(service);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  //Metodo para listar los productos dentro de la categoria
  Future<List<Service>> findByCategory(String idCategory) async {
    Response response = await get('$url/findByCategory/$idCategory', headers: {
      'Content_Type': 'application/json',
      'Authorization': userSession.sessionToken! ?? ''
    });
    if (response.statusCode == 401) {
      Get.snackbar('Peticion Denegada',
          'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }
    List<Service> services = Service.fromJsonList(response.body);
    return services;
  }
}

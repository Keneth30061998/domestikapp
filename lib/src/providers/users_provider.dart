import 'dart:convert';
import 'dart:io';

import 'package:domestik_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:domestik_app/src/environment/environment.dart';

import '../models/response_api.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider extends GetConnect {
  String url = '${Environment.API_URL}api/users';

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {'Content-Type': 'application/json'},
    ); //ESPERAR HATA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    return response;
  }

  //Provider para actualizar los datos del usuario - sin imagen
  Future<ResponseApi> update(User user) async {
    Response response = await put(
      '$url/updateWithoutImage',
      user.toJson(),
      headers: {'Content-Type': 'application/json'},
    ); //ESPERAR HATA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if(response.body == null){
      Get.snackbar('Error', 'Error al actualizar los datos');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  //Provide para actualizar datos del usuario - con imagen
  Future<Stream> updateWithImage(User user, File image)async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }


  Future<Stream> createWithImage(User user, File image)async {
    Uri uri = Uri.http(Environment.API_URL_OLD, 'api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password
      },
      headers: {'Content-Type': 'application/json'},
    ); //ESPERAR HATA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if(response.body == null){
      Get.snackbar('Error', 'No se puede ejecutar la petición');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}

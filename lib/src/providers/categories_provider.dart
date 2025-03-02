import 'package:domestik_app/src/environment/environment.dart';
import 'package:domestik_app/src/models/category.dart';
import 'package:domestik_app/src/models/response_api.dart';
import 'package:domestik_app/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoriesProvider extends GetConnect {
  String url = Environment.API_URL + 'api/categories';

  //se requiere el usuario - con la sesion iniciada
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  //se requiere un model - category
  Future<ResponseApi> create(Category category) async {
    Response response = await post('$url/create', category.toJson(), headers: {
      'Content.Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    });

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  //Para Listar las caregorias
  Future<List<Category>> getAll() async {
    Response response = await get('$url/getAll', headers: {
      'Content-Type': 'aplication/json',
      'Authorization': userSession.sessionToken ?? ''
    });

    //Validacion en caso de haber conflicto
    if (response.status == 401) {
      Get.snackbar('Peticion Denegada',
          'Usuario sin permisos para leer esta informacion');
      return [];
    }
    List<Category> categories = Category.fromJsonList(response.body);
    return categories;
  }
}

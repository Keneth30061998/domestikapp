import 'package:domestik_app/src/models/user.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_page.dart';
import 'package:domestik_app/src/pages/home/home_page.dart';
import 'package:domestik_app/src/pages/login/login_page.dart';
import 'package:domestik_app/src/pages/premises/orders/list/premises_orders_list_page.dart';
import 'package:domestik_app/src/pages/register/register_page.dart';
import 'package:domestik_app/src/pages/roles/roles_page.dart';
import 'package:domestik_app/src/pages/worker/orders/list/worker_orders_list_page.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('client') ?? {});

void main() async{
  //Para poder almacenar el incio de sesion usamos GetStorage, modificamos un poco el main
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Domestik App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black26),
        useMaterial3: true,
        //colores de los elevated button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color_primary),
            foregroundColor: MaterialStatePropertyAll(background_elevatedButton),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: (background_elevatedButton)
        )

      ),
      initialRoute: userSession.id!=null ? userSession.roles!.length > 1 ? '/roles' : '/client/services/list' : '/' ,
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: ()=>HomePage()),
        GetPage(name: '/roles', page: ()=>RolesPage()),
        GetPage(name: '/premises/orders/list', page: ()=>PremisesOrdersListPage()),
        GetPage(name: '/worker/orders/list', page: ()=>WorkerOrdersListPage()),
        GetPage(name: '/client/services/list', page: ()=>ClientServicesListPage()),
      ],
    );
  }
}

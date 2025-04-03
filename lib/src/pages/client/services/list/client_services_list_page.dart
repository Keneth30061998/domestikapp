import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:domestik_app/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:domestik_app/src/pages/client/services/list/client_services_list_controller.dart';
import 'package:domestik_app/src/utils/color.dart';
import 'package:domestik_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:domestik_app/src/models/service.dart';

import '../../../../models/category.dart';

class ClientServicesListPage extends StatelessWidget {
  ClientServicesListController con = Get.put(ClientServicesListController());

  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: con.categories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              bottom: TabBar(
                indicatorColor: color_primary,
                labelColor: color_primary,
                unselectedLabelColor: Colors.grey[400],
                tabs: List<Widget>.generate(con.categories.length, (index) {
                  return Tab(
                    child: Text(con.categories[index].name ?? ''),
                  );
                }),
                isScrollable: true,
              ),
            ),
          ),
          body: TabBarView(
            children: con.categories.map((Category category) {
              return FutureBuilder(
                  future: con.getServices(category.id ?? '1'),
                  builder: (context, AsyncSnapshot<List<Service>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        //Si queremos que se vean en forma de columnas usamos GridView
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardService(
                                  snapshot.data![index], context);
                            });
                      } else {
                        //sino llegan datos
                        return NoDataWidget(
                          text: 'No hay servicios',
                        );
                      }
                    } else {
                      //sino llegan datos
                      return NoDataWidget(
                        text: 'No hay servicios',
                      );
                    }
                  });
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _cardService(Service service, BuildContext context) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(service, context),
      child: Card(
        color: background_form,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  height: 70,
                  width: 80,
                  fit: BoxFit.cover,
                  image: service.image1 != null
                      ? NetworkImage(service.image1!)
                      : AssetImage('assets/img/noImage.jpg') as ImageProvider,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      service.description ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$ ${service.price.toString()}',
                      style: TextStyle(
                          fontSize: 17,
                          color: color_primary,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              //Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
            ],
          ),
        ),
      ),
    );
  }
}

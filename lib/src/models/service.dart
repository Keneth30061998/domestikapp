import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    String? id;
    String? name;
    String? description;
    String? image1;
    String? image2;
    String? image3;
    String? idCategory;
    double? price;
    int? quantity;

    Service({
        this.id,
        this.name,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.idCategory,
        this.price,
        this.quantity,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        idCategory: json["id_category"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "id_category": idCategory,
        "price": price,
        "quantity": quantity,
    };
}

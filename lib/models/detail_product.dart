// To parse this JSON data, do
//
//     final detailProduct = detailProductFromJson(jsonString);

import 'dart:convert';

class DetailProduct {
  DetailProduct({
    this.resp,
    this.msj,
    this.product,
  });

  bool? resp;
  String? msj;
  Product? product;

  factory DetailProduct.fromJson(Map<String, dynamic> json) => DetailProduct(
    resp: json["resp"],
    msj: json["msj"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "resp": resp,
    "msj": msj,
    "product": product!.toJson(),
  };
}

class Product {
  Product({
    this.idProduct,
    this.nameProduct,
    this.description,
    this.price,
    this.status,
    this.discount,
    this.picture,
    this.quantily,
    this.sold,
    this.colors,
    this.brandsId,
    this.subcategoryId,
    this.addDay,
    this.updateday,
    this.importPrice,
  });

  int? idProduct;
  String? nameProduct;
  String? description;
  int? price;
  int? status;
  int? discount;
  List<String>? picture;
  int? quantily;
  int? sold;
  List<String>? colors;
  int? brandsId;
  int? subcategoryId;
  int? addDay;
  int? updateday;
  int? importPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    idProduct: json["idProduct"],
    nameProduct: json["nameProduct"],
    description: json["description"],
    price: json["price"],
    status: json["status"],
    discount: json["discount"],
    picture: List<String>.from(json["picture"].map((x) => x)),
    quantily: json["quantily"],
    sold: json["sold"],
    colors: List<String>.from(json["colors"].map((x) => x)),
    brandsId: json["brands_id"],
    subcategoryId: json["subcategory_id"],
    addDay: json["addDay"],
    updateday: json["updateday"],
    importPrice: json["importPrice"],
  );

  Map<String, dynamic> toJson() => {
    "idProduct": idProduct,
    "nameProduct": nameProduct,
    "description": description,
    "price": price,
    "status": status,
    "discount": discount,
    "picture": List<dynamic>.from(picture!.map((x) => x)),
    "quantily": quantily,
    "sold": sold,
    "colors": List<dynamic>.from(colors!.map((x) => x)),
    "brands_id": brandsId,
    "subcategory_id": subcategoryId,
    "addDay": addDay,
    "updateday": updateday,
    "importPrice": importPrice,
  };
}

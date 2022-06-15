class SubcategoriesResponse {
  SubcategoriesResponse({
    this.resp,
    this.msj,
    this.subcategory,
  });

  bool? resp;
  String? msj;
  List<Subcategory>? subcategory;

  factory SubcategoriesResponse.fromJson(Map<String, dynamic> json) => SubcategoriesResponse(
    resp: json["resp"],
    msj: json["msj"],
    subcategory: List<Subcategory>.from(json["subcategory"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resp": resp,
    "msj": msj,
    "subcategory": List<dynamic>.from(subcategory!.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.picture,
    this.categoryId,
    this.status,
    this.views,
    this.icon,
  });

  int? id;
  String? name;
  String? picture;
  int? categoryId;
  int? status;
  int? views;
  String? icon;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    categoryId: json["category_id"],
    status: json["status"],
    views: json["views"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "category_id": categoryId,
    "status": status,
    "views": views,
    "icon": icon,
  };
}

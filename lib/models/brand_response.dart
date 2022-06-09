class BrandResponse {
  bool? resp;
  String? msj;
  List<Brands>? brands;

  BrandResponse({this.resp, this.msj, this.brands});

  BrandResponse.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int? idBrands;
  String? brand;
  String? picture;
  int? status;

  Brands({this.idBrands, this.brand, this.picture, this.status});

  Brands.fromJson(Map<String, dynamic> json) {
    idBrands = json['idBrands'];
    brand = json['brand'];
    picture = json['picture'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBrands'] = this.idBrands;
    data['brand'] = this.brand;
    data['picture'] = this.picture;
    data['status'] = this.status;
    return data;
  }
}
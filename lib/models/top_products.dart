class TopProducts {
  bool? resp;
  String? msj;
  List<TopProduct>? topProducts;

  TopProducts({this.resp, this.msj, this.topProducts});

  TopProducts.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['topProducts'] != null) {
      topProducts = <TopProduct>[];
      json['topProducts'].forEach((v) {
        topProducts!.add(new TopProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.topProducts != null) {
      data['topProducts'] = this.topProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopProduct {
  String? nameProduct;
  List<String>? picture;
  int? sold;
  int? price;

  TopProduct({this.nameProduct, this.picture, this.sold, this.price});

  TopProduct.fromJson(Map<String, dynamic> json) {
    nameProduct = json['nameProduct'];
    picture = json['picture'].cast<String>();
    sold = json['sold'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameProduct'] = this.nameProduct;
    data['picture'] = this.picture;
    data['sold'] = this.sold;
    data['price'] = this.price;
    return data;
  }
}
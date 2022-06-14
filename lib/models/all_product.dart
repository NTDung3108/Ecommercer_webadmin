class ProductsResponse {
  bool? resp;
  String? msj;
  List<Products>? products;

  ProductsResponse({this.resp, this.msj, this.products});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? idProduct;
  String? nameProduct;
  String? brand;
  String? name;
  int? quantily;
  int? sold;
  int? price;
  int? importPrice;
  String? addDay;
  String? updateDay;

  Products(
      {this.idProduct,
        this.nameProduct,
        this.brand,
        this.name,
        this.quantily,
        this.sold,
        this.price,
        this.importPrice,
        this.addDay,
        this.updateDay});

  Products.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    nameProduct = json['nameProduct'];
    brand = json['brand'];
    name = json['name'];
    quantily = json['quantily'];
    sold = json['sold'];
    price = json['price'];
    importPrice = json['importPrice'];
    addDay = json['addDay'];
    updateDay = json['updateDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['nameProduct'] = this.nameProduct;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['quantily'] = this.quantily;
    data['sold'] = this.sold;
    data['price'] = this.price;
    data['importPrice'] = this.importPrice;
    data['addDay'] = this.addDay;
    data['updateDay'] = this.updateDay;
    return data;
  }
}
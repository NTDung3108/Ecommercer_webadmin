class SumProduct {
  bool? resp;
  String? msj;
  int? sumProduct;

  SumProduct({this.resp, this.msj, this.sumProduct});

  SumProduct.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    sumProduct = json['sumProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    data['sumProduct'] = this.sumProduct;
    return data;
  }
}
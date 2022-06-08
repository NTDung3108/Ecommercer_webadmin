class SumOrder {
  bool? resp;
  String? msj;
  int? sumOrder;

  SumOrder({this.resp, this.msj, this.sumOrder});

  SumOrder.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    sumOrder = json['sumOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    data['sumOrder'] = this.sumOrder;
    return data;
  }
}
class RevenueStatistic {
  bool? resp;
  String? msj;
  List<Revenue>? revenue;

  RevenueStatistic({this.resp, this.msj, this.revenue});

  RevenueStatistic.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'] ?? '';
    if (json['revenue'] != null) {
      revenue = <Revenue>[];
      json['revenue'].forEach((v) {
        revenue!.add(new Revenue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.revenue != null) {
      data['revenue'] = this.revenue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Revenue {
  int? uidOrderBuy;
  String? datee2;
  int? amounts;
  int? taxs;
  int? totalOriginals;

  Revenue(
      {this.uidOrderBuy,
        this.datee2,
        this.amounts,
        this.taxs,
        this.totalOriginals});

  Revenue.fromJson(Map<String, dynamic> json) {
    uidOrderBuy = json['uidOrderBuy'];
    datee2 = json['datee2'];
    amounts = json['amounts'];
    taxs = json['taxs'];
    totalOriginals = json['total_originals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uidOrderBuy'] = this.uidOrderBuy;
    data['datee2'] = this.datee2;
    data['amounts'] = this.amounts;
    data['taxs'] = this.taxs;
    data['total_originals'] = this.totalOriginals;
    return data;
  }
}
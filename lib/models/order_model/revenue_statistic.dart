class RevenueStatistic {
  bool? resp;
  String? msj;
  List<Revenue>? revenue;

  RevenueStatistic({this.resp, this.msj, this.revenue});

  RevenueStatistic.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
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
  int? amount;
  int? datee;

  Revenue({this.amount, this.datee});

  Revenue.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    datee = json['datee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['datee'] = this.datee;
    return data;
  }
}

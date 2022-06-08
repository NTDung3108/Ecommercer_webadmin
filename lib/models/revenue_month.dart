class RevenueMonth {
  bool? resp;
  String? msj;
  RevenueHome? revenue;

  RevenueMonth({this.resp, this.msj, this.revenue});

  RevenueMonth.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    revenue =
    json['revenue'] != null ? new RevenueHome.fromJson(json['revenue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.revenue != null) {
      data['revenue'] = this.revenue!.toJson();
    }
    return data;
  }
}

class RevenueHome {
  int? amount;
  int? tax;
  int? totalOriginal;

  RevenueHome({this.amount, this.tax, this.totalOriginal});

  RevenueHome.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    tax = json['tax'];
    totalOriginal = json['total_original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['total_original'] = this.totalOriginal;
    return data;
  }
}
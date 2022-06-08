class TopBuyer {
  bool? resp;
  String? msj;
  List<Buyers>? buyers;

  TopBuyer({this.resp, this.msj, this.buyers});

  TopBuyer.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['buyers'] != null) {
      buyers = <Buyers>[];
      json['buyers'].forEach((v) {
        buyers!.add(new Buyers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.buyers != null) {
      data['buyers'] = this.buyers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buyers {
  int? numberOfOrder;
  int? amount;
  String? firstName;
  String? lastName;
  String? image;

  Buyers(
      {this.numberOfOrder,
        this.amount,
        this.firstName,
        this.lastName,
        this.image});

  Buyers.fromJson(Map<String, dynamic> json) {
    numberOfOrder = json['NumberOfOrder'];
    amount = json['amount'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NumberOfOrder'] = this.numberOfOrder;
    data['amount'] = this.amount;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}
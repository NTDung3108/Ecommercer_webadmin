class OrderResponse {
  bool? resp;
  String? msj;
  List<Orders>? orders;

  OrderResponse({this.resp, this.msj, this.orders});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? uidOrderBuy;
  String? userId;
  String? firstName;
  String? lastName;
  String? phone;
  int? status;
  String? datee;
  int? amount;
  String? address;
  String? note;
  String? payment;
  String? reason;

  Orders(
      {this.uidOrderBuy,
        this.userId,
        this.firstName,
        this.lastName,
        this.phone,
        this.status,
        this.datee,
        this.amount,
        this.address,
        this.note,
        this.payment,
        this.reason});

  Orders.fromJson(Map<String, dynamic> json) {
    uidOrderBuy = json['uidOrderBuy'];
    userId = json['user_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    status = json['status'];
    datee = json['datee'];
    amount = json['amount'];
    address = json['address'];
    note = json['note'];
    payment = json['payment'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uidOrderBuy'] = this.uidOrderBuy;
    data['user_id'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['datee'] = this.datee;
    data['amount'] = this.amount;
    data['address'] = this.address;
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['reason'] = this.reason;
    return data;
  }
}
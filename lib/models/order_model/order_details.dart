class OrderDetails {
  bool? resp;
  String? msj;
  OrderDetail? orderDetail;

  OrderDetails({this.resp, this.msj, this.orderDetail});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    orderDetail = json['order_detail'] != null
        ? new OrderDetail.fromJson(json['order_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  int? orderId;
  String? userName;
  String? address;
  String? phone;
  int? amount;
  String? note;
  String? reason;
  String? payment;
  int? status;
  List<Details>? details;

  OrderDetail(
      {this.orderId,
        this.userName,
        this.address,
        this.phone,
        this.amount,
        this.note,
        this.reason,
        this.payment,
        this.status,
        this.details});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userName = json['user_name'] ?? '';
    address = json['address'] ?? '';
    phone = json['phone'] ?? '';
    amount = json['amount'] ?? 0;
    note = json['note'] ?? '';
    reason = json['reason'] ?? '';
    payment = json['payment'] ?? '';
    status = json['status'] ?? -1;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_name'] = this.userName;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['reason'] = this.reason;
    data['payment'] = this.payment;
    data['status'] = this.status;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? nameProduct;
  int? quantity;
  int? price;

  Details({this.nameProduct, this.quantity, this.price});

  Details.fromJson(Map<String, dynamic> json) {
    nameProduct = json['nameProduct'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameProduct'] = this.nameProduct;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}
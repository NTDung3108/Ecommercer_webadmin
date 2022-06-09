class DiscountResponse {
  bool? resp;
  String? msj;
  List<Discounr>? discounr;

  DiscountResponse({this.resp, this.msj, this.discounr});

  DiscountResponse.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['discounr'] != null) {
      discounr = <Discounr>[];
      json['discounr'].forEach((v) {
        discounr!.add(new Discounr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.discounr != null) {
      data['discounr'] = this.discounr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discounr {
  int? idDiscount;
  String? title;
  String? content;
  String? picture;
  int? discount;
  int? startTime;
  int? endTime;
  Null? status;

  Discounr(
      {this.idDiscount,
        this.title,
        this.content,
        this.picture,
        this.discount,
        this.startTime,
        this.endTime,
        this.status});

  Discounr.fromJson(Map<String, dynamic> json) {
    idDiscount = json['idDiscount'];
    title = json['title'];
    content = json['content'];
    picture = json['picture'];
    discount = json['discount'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDiscount'] = this.idDiscount;
    data['title'] = this.title;
    data['content'] = this.content;
    data['picture'] = this.picture;
    data['discount'] = this.discount;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}
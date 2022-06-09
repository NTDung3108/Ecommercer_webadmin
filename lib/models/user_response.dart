class UsersResponse {
  bool? resp;
  String? msj;
  List<Users>? users;

  UsersResponse({this.resp, this.msj, this.users});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp'] = this.resp;
    data['msj'] = this.msj;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? uid;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? image;
  String? created;
  String? sex;
  int? statuss;

  Users(
      {this.uid,
        this.firstName,
        this.lastName,
        this.phone,
        this.address,
        this.image,
        this.created,
        this.sex,
        this.statuss});

  Users.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
    created = json['created'];
    sex = json['sex'];
    statuss = json['statuss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['image'] = this.image;
    data['created'] = this.created;
    data['sex'] = this.sex;
    data['statuss'] = this.statuss;
    return data;
  }
}
class AuthModel {
  bool? resp;
  String? msj;
  Users? users;
  String? token;
  String? refreshToken;

  AuthModel({this.resp, this.msj, this.users, this.token, this.refreshToken});

  AuthModel.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resp'] = resp;
    data['msj'] = msj;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class Users {
  String? id;
  String? phone;
  String? image;

  Users({this.id, this.phone, this.image});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}
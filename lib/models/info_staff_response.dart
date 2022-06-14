class InfoStaffResponse {
  InfoStaffResponse({
    this.resp,
    this.msj,
    this.information,
  });

  bool? resp;
  String? msj;
  Information? information;

  factory InfoStaffResponse.fromJson(Map<String, dynamic> json) => InfoStaffResponse(
    resp: json["resp"],
    msj: json["msj"],
    information: Information.fromJson(json["information"]),
  );

  Map<String, dynamic> toJson() => {
    "resp": resp,
    "msj": msj,
    "information": information!.toJson(),
  };
}

class Information {
  Information({
    this.sid,
    this.firstName,
    this.lastName,
    this.sex,
    this.phone,
    this.email,
    this.address,
    this.image,
  });

  String? sid;
  String? firstName;
  String? lastName;
  String? sex;
  String? phone;
  String? email;
  String? address;
  String? image;

  factory Information.fromJson(Map<String, dynamic> json) => Information(
    sid: json["sid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    sex: json["sex"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "sid": sid,
    "firstName": firstName,
    "lastName": lastName,
    "sex": sex,
    "phone": phone,
    "email": email,
    "address": address,
    "image": image,
  };
}

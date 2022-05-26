class Response {
  bool? resp;
  String? msj;

  Response({this.resp, this.msj});

  Response.fromJson(Map<String, dynamic> json) {
    resp = json['resp'];
    msj = json['msj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resp'] = resp;
    data['msj'] = msj;
    return data;
  }
}
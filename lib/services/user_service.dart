import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/user_response.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class UserService{
  HttpClient httpClient = HttpClient();
  Future<List<Users>?> getAllUser() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allUser, token: token!);
    if(response.statusCode == 200){
      return UsersResponse.fromJson(jsonDecode(response.body)).users;
    }else{
      throw Exception();
    }
  }
}
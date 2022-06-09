import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/discount_responese.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class DiscountService{
  HttpClient httpClient = HttpClient();
  Future<List<Discounr>?> getAllDiscount() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allDiscount, token!);
    if(response.statusCode == 200){
      return DiscountResponse.fromJson(jsonDecode(response.body)).discounr;
    }else{
      throw Exception();
    }
  }
}
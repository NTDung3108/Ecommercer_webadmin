import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/brand_response.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class BrandsServices {
  HttpClient httpClient = HttpClient();
  Future<List<Brands>?> getAllBrands() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allBrands, token: token);
    if(response.statusCode == 200){
      return BrandResponse.fromJson(jsonDecode(response.body)).brands;
    }else{
      return [];
    }
  }
}

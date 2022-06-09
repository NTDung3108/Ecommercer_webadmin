import 'dart:convert';
import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/all_product.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class ProductsServices {
  HttpClient httpClient = HttpClient();
  Future<List<Products>?> getAllProducts() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allProduct, token!);
    if(response.statusCode == 200){
      return ProductsResponse.fromJson(jsonDecode(response.body)).products;
    }else{
      throw Exception();
    }
  }
}

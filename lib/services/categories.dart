import 'dart:convert';
import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/subcategory.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class CategoriesServices {
  HttpClient httpClient = HttpClient();
  Future<List<Subcategory>?> getAllSubcategory() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allSubcategory, token: token);
    if(response.statusCode == 200){
      return SubcategoriesResponse.fromJson(jsonDecode(response.body)).subcategory;
    }else{
      return [];
    }
  }
}

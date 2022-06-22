import 'dart:convert';
import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/all_product.dart';
import 'package:ecommerce_admin_tut/models/detail_product.dart';
import 'package:ecommerce_admin_tut/models/response.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';

class ProductsServices {
  HttpClient httpClient = HttpClient();

  Future<List<Products>?> getAllProducts() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.allProduct, token: token);
    if (response.statusCode == 200) {
      return ProductsResponse.fromJson(jsonDecode(response.body)).products;
    } else {
      throw Exception();
    }
  }

  Future<DetailProduct?> getDetailProducts(int id) async {
    var response = await httpClient.get('${Address.detailProduct}$id');
    if (response.statusCode == 200)
      return DetailProduct.fromJson(jsonDecode(response.body));
    return null;
  }

  Future<Response> updateProduct (
      int id,
      String name,
      String description,
      int price,
      int discount,
      int quantity,
      String colors,
      int brandId,
      int subcategory,
      int importPrice) async {
    var token = await AuthServices().readToken();

    Map<String, dynamic> data = {
      'in_idProduct': id,
      'in_nameProduct': name,
      'in_description': description,
      'in_price': price,
      'in_discount': discount,
      'in_quantily': quantity,
      'in_colors': colors,
      'in_brands_id': brandId,
      'in_subcategory_id': subcategory,
      'in_importPrice': importPrice
    };

    var body = jsonEncode(data);

    var resp = await httpClient.put('${Address.updateProduct}', token!, body);

    if(resp.statusCode == 200){
      return Response.fromJson(jsonDecode(resp.body));
    }
    return Response(resp: false, msj: 'error');
  }

  Future<Response> deleteProduct (int id,) async {
    var token = await AuthServices().readToken();

    Map<String, dynamic> data = {
      'idProduct': id,
    };

    var body = jsonEncode(data);

    var resp = await httpClient.put('${Address.deleteProduct}', token!, body);

    if(resp.statusCode == 200){
      return Response.fromJson(jsonDecode(resp.body));
    }
    return Response(resp: false, msj: 'error');
  }
}

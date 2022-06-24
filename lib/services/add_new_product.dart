import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';
import 'package:http_parser/http_parser.dart';

class AddNewProduct{
  Future<Response> newProduct(String path,
      {required List<Uint8List> images,
        required List<String> fileName,
        required String name,
        required String description,
        required int price,
        required int discount,
        required int quantity,
        required String colors,
        required int brand,
        required int subcategory,
        required int importPrice}) async {
    final Dio _dio = Dio();
    _dio.options.baseUrl = 'http://192.168.2.101:3000/api';
    var formData = FormData.fromMap({
      'in_nameProduct': name,
      'in_description': description,
      'in_price': price.toString(),
      'in_discount': discount.toString(),
      'in_quantily': quantity.toString(),
      'in_colors': colors,
      'in_brands_id': brand.toString(),
      'in_subcategory_id': subcategory.toString(),
      'in_importPrice': importPrice.toString(),
      'many-files': [
        MultipartFile.fromBytes(images[0],
            filename: fileName[0], contentType: MediaType("image", "jpg")),
        MultipartFile.fromBytes(images[1],
            filename: fileName[1], contentType: MediaType("image", "jpg")),
        MultipartFile.fromBytes(images[2],
            filename: fileName[2], contentType: MediaType("image", "jpg")),
        MultipartFile.fromBytes(images[3],
            filename: fileName[3], contentType: MediaType("image", "jpg")),
        MultipartFile.fromBytes(images[4],
            filename: fileName[4], contentType: MediaType("image", "jpg")),
      ]
    });
    final token = await AuthServices().readToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Accept": "*/*",
      "xx-token": token!
    };

    _dio.options.headers.addAll(headers);

    return await _dio.post(
      path,
      data: formData,
    );
  }
}
import 'dart:convert';
import 'package:ecommerce_admin_tut/models/info_staff_response.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';

class UserServices2 {
  static String server = 'http://10.50.10.135:3000/api';
  // static String server = 'http://192.168.2.101:3000/api';

  // static String server = 'http://192.168.2.151:3000/api';
  static var client = http.Client();
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static Future<Response> registerUserInfo(
      {String? firstName,
      String? lastName,
      String? phone,
      String? address,
      String? gender,
      String? email,
      String? uid}) async {
    Uri uri = Uri.parse('$server/staff/register');

    final resp = await client.put(
      uri,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'sid': uid,
        'nam': firstName,
        'lastt': lastName,
        'phone': phone,
        'gender': gender,
        'email': email,
        'address': address
      },
    );

    return Response.fromJson(jsonDecode(resp.body));
  }

  static Future<Response?> checkPhoneNumber(String phone) async {
    Uri uri = Uri.parse('$server/check-phone/$phone');

    var respose = await client.get(uri);

    if (respose.statusCode == 200) {
      var jsonString = respose.body;
      return Response.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  static Future<Response?> forgotPassword(
      {required String password, required String phone}) async {
    Uri uri = Uri.parse('$server/forgot-password');

    final response = await client.put(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {'passwordd': password, 'phone': phone},
    );

    return Response.fromJson(jsonDecode(response.body));
  }

  static Future<InfoStaffResponse?> getInfomationStaff(
      {required String sid}) async {
    var token = await AuthServices().readToken();
    Uri uri = Uri.parse('$server/staff/get-info-staff/$sid');

    final response = await client
        .get(uri, headers: {'Accept': 'application/json', 'xx-token': token!});
    if (response.statusCode == 200)
      return InfoStaffResponse.fromJson(jsonDecode(response.body));
    return null;
  }
}

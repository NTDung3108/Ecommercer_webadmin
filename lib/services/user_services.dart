import 'dart:convert';
import 'package:ecommerce_admin_tut/services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';

class UserServices2 {
  static String server = 'http://192.168.2.151:3000/api';
  static var client = http.Client();
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // static Future<Information?> getPersonInformation() async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/get-personal-information');
  //
  //   final response = await client.get(uri,
  //       headers: {'Accept': 'application/json', 'xx-token': '$token'});
  //
  //   return UserInformation.fromJson(jsonDecode(response.body)).information;
  // }

  static Future<Response> registerUserInfo(
      {String? firstName,
      String? lastName,
      String? phone,
      String? address,
      String? reference,
      String? uid}) async {
    Uri uri = Uri.parse('$server/personal/register');

    final resp = await client.put(
      uri,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'firstname': firstName,
        'lastname': lastName,
        'phone': phone,
        'address': address,
        'reference': reference,
        'uid': uid
      },
    );

    return Response.fromJson(jsonDecode(resp.body));
  }

  // static Future<UpdateProfile> updateImageProfile(String? image, String? uid) async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/update-image-profile');
  //
  //   var request = http.MultipartRequest('PUT', uri)
  //     ..headers['Accept'] = 'application/json'
  //     ..headers['xx-token'] = token!
  //     ..fields['uidPerson'] = uid!
  //     ..files.add(await http.MultipartFile.fromPath('image', image!));
  //
  //   final resp = await request.send();
  //
  //   var data = await http.Response.fromStream(resp);
  //
  //   return UpdateProfile.fromJson(jsonDecode(data.body));
  // }

  // static Future<Response?> updateFirstName(String? firstName) async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/personal/updateFirstName');
  //
  //   final response = await client.put(
  //     uri,
  //     headers: {'Accept': 'application/json',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       'xx-token': '$token'
  //     },
  //     body: {
  //       'firstName': firstName,
  //     },
  //   );
  //
  //   return Response.fromJson(jsonDecode(response.body));
  // }
  //
  // static Future<Response?> updateLastName(String? lastName) async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/personal/updateLastName');
  //
  //   final response = await client.put(
  //     uri,
  //     headers: {'Accept': 'application/json',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       'xx-token': '$token'},
  //     body: {
  //       'lastName': lastName,
  //     },
  //   );
  //
  //   return Response.fromJson(jsonDecode(response.body));
  // }
  //
  // static Future<Response?> updatePhone(String? phone) async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/personal/updatePhone');
  //
  //   final response = await client.put(
  //     uri,
  //     headers: {'Accept': 'application/json',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       'xx-token': '$token'},
  //     body: {
  //       'phone': phone,
  //     },
  //   );
  //
  //   return Response.fromJson(jsonDecode(response.body));
  // }
  //
  // static Future<Response?> updateAddress(String? address) async {
  //   final token = await AuthServices().readToken();
  //
  //   Uri uri = Uri.parse('$server/personal/updateAddress');
  //
  //   final response = await client.put(
  //     uri,
  //     headers: {'Accept': 'application/json',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       'xx-token': '$token'},
  //     body: {
  //       'address': address,
  //     },
  //   );
  //
  //   return Response.fromJson(jsonDecode(response.body));
  // }

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
      headers: {'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'passwordd': password,
        'phone': phone
      },
    );

    return Response.fromJson(jsonDecode(response.body));
  }
}

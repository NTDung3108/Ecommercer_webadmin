import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_admin_tut/models/response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/auth/auth_response.dart';
import '../models/auth/update_profile_response.dart';

class AuthServices {
  // static String server = 'http://10.50.10.135:3000/api';
  static String server = 'http://192.168.2.151:3000/api';
  static var client = http.Client();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static createUsers({String? phone, String? password, String? idUser}) async {
    Uri uri = Uri.parse('$server/register-staff');

    final resp = await client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'phone': phone, 'password': password, 'idUser': idUser});

    return Response.fromJson(jsonDecode(resp.body));
  }

  static Future<AuthModel> login({String? phone, String? password}) async {
    Uri uri = Uri.parse('$server/login-staff');
    final resp = await client.post(uri,
        headers: {'Accept': 'application/json'},
        body: {'phone': phone, 'password': password});

    return AuthModel.fromJson(jsonDecode(resp.body));
  }

  Future<AuthModel> renewToken() async {
    final token = await readToken();

    Uri uri = Uri.parse('$server/login/renew');

    final resp = await client.get(uri,
        headers: {'Accept': 'application/json', 'xx-token': '$token'});

    return AuthModel.fromJson(jsonDecode(resp.body));
  }

  Future<UpdateProfile> updateImageProfile(
      {required String image, required String uidPerson}) async {
    final token = await readToken();

    var request =
        http.MultipartRequest('PUT', Uri.parse('$server/update-image-profile'))
          ..headers['Accept'] = 'application/json'
          ..headers['xx-token'] = '$token'
          ..fields['uidPerson'] = uidPerson
          ..files.add(await http.MultipartFile.fromPath('image', image));

    final resp = await request.send();
    var datas = await http.Response.fromStream(resp);

    return UpdateProfile.fromJson(jsonDecode(datas.body));
  }

  // Flutter Secure Storage

  Future<void> persistenToken(String? token, String? reToken) async {
    await secureStorage.write(key: 'xtoken', value: token);
    await secureStorage.write(key: 'refreshToken', value: reToken);
  }

  Future<String?> uidPersonStorage() async {
    return secureStorage.read(key: 'uid');
  }

  Future<bool> hasToken() async {
    var value = await secureStorage.read(key: 'xtoken');

    if (value != null) return true;
    return false;
  }

  Future<String?> readToken() async {
    log('${secureStorage.read(key: 'xtoken')}');
    return secureStorage.read(key: 'xtoken');
  }

  Future<String> readReToken() async {
    return '${secureStorage.read(key: 'refreshToken')}';
  }

  Future<void> deleteToken() async {
    secureStorage.delete(key: 'xtoken');
    secureStorage.deleteAll();
  }
}

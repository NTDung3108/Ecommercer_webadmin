import 'dart:async';
import 'dart:developer';
import 'package:ecommerce_admin_tut/models/auth/auth_response.dart';
import 'package:ecommerce_admin_tut/pages/otp_screen/otp_page.dart';
import 'package:ecommerce_admin_tut/pages/registration/registration.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/auth_services.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helpers/costants.dart';
import '../locator.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  ConfirmationResult? confirmationResult;

  Users users = Users();

  Future<bool> signIn(String phone, String pass) async {
    final sercureStorage = FlutterSecureStorage();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var response = await AuthServices.login(phone: phone, password: pass);
      if (response.resp!) {
        log('${response.msj}');

        await AuthServices()
            .persistenToken(response.token, response.refreshToken);

        await sercureStorage.write(key: 'uid', value: response.users?.id);
        await sercureStorage.write(key: 'phone', value: response.users?.phone);
        await sercureStorage.write(key: 'image', value: response.users?.image);
        notifyListeners();
        return true;
      }
      _status = Status.Unauthenticated;
      log('${response.msj}');
      notifyListeners();
      return false;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      throw Exception(e);
    }
  }

  void verifyPhone(String phoneNumber, BuildContext context) async {
    confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
    locator<NavigationService>().globalNavigateTo(OTPRoute, context);
  }

  void otp(String smsCode, BuildContext context) async {
    UserCredential userCredential = await confirmationResult!.confirm(smsCode);
    if (userCredential != null) {
      locator<NavigationService>().globalNavigateTo(RegistrationRoute, context);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<bool> registerUser(String phone, String password, String idUser,
      BuildContext context) async {
    try {
      final resp = await AuthServices.createUsers(
          phone: phone, password: password, idUser: idUser);
      if (resp.resp == true) {
        log('${resp.msj}');
        return true;
      } else {
        log('${resp.msj}');
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void logout(BuildContext context) async {
    try {
      final secureStore = FlutterSecureStorage();

      await secureStore.deleteAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void changePhotoProfile(String image) async {
    try {
      final secureStorage = FlutterSecureStorage();

      var uidPerson = await AuthServices().uidPersonStorage();

      final resp = await AuthServices()
          .updateImageProfile(image: image, uidPerson: '$uidPerson');

      await secureStorage.write(key: 'profile', value: resp.profile);

      users.image = resp.profile;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> checkPhone(String phone, BuildContext context) async {
    var resp = await UserServices2.checkPhoneNumber(phone);

    if (resp!.resp!) {
      log('${resp.msj}');
      return true;
    } else {
      log('${resp.msj}');
      return false;
    }
  }
}

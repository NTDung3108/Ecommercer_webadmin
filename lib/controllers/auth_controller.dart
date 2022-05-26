import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auth/auth_response.dart';
import '../services/auth_services.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser;

  String verificationId = '';

  var token = ''.obs;
  var isLoading = true.obs;

  var forgotPass = false;
  var phone = '';

  Rx<Users> user = Users().obs;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    _firebaseUser = Rx<User?>(_auth.currentUser);

    _firebaseUser.bindStream(_auth.userChanges());
  }

  void verifyPhone(String phoneNumber, BuildContext context, bool b) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '+1$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          if (userCredential.user != null) {
            //Navigator.pushNamed(context, OTPScreen.routeName);
          } else {
            print("Error");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          log(this.verificationId);
          const snackBar = SnackBar(
            content: Text('Otp code has been sent'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //Navigator.pushNamed(context, OTPScreen.routeName);
          // if(b){
          //   Navigator.pushNamed(context, OTPScreen.routeName);
          // }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          print(verificationId);
          print("Timout");
        },
        timeout: const Duration(seconds: 60));
  }

  void otp(String smsCode, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: smsCode);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    if (userCredential != null) {
      //Navigator.pushNamed(context, SignUpScreen.routeName);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  void registerUser(String phone, String password, String idUser,
      BuildContext context) async {
    try {
      final resp = await AuthServices.createUsers(
          phone: phone, password: password, idUser: idUser);
      if (resp.resp == true) {
        log('${resp.msj}');
      } else {
        log('${resp.msj}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

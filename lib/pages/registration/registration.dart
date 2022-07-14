import 'dart:developer';

import 'package:ecommerce_admin_tut/pages/register_info/register_info_page.dart';
import 'package:ecommerce_admin_tut/provider/auth.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/form_error.dart';
import 'package:ecommerce_admin_tut/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? password;

  String? rePassword;

  bool showPassword = false;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.indigo.shade600])),
      child: _authProvider.status == Status.Authenticating
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  color: Colors.red,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 24)
                        ]),
                    height: 420,
                    width: 350,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: _authProvider.isForgot
                                ? 'Đổi Mật Khẩu'
                                : "Đăng Kí",
                            size: 22,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !showPassword,
                                  onSaved: (newValue) => password = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(
                                          error: "Mật khẩu không được để trống");
                                      removeError(
                                          error: "Mật khẩu quá ngắn");
                                    }
                                    password = value;
                                    return;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      addError(error: "Mật khẩu không được để trống");
                                      return "";
                                    } else if (value.length < 6) {
                                      addError(error: "Mật khẩu quá ngắn");
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Mật khẩu',
                                      icon: Icon(Icons.lock_outline)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: rePasswordController,
                                  obscureText: !showPassword,
                                  onSaved: (newValue) => rePassword = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(
                                          error: "Mật khẩu không được để trống");
                                      removeError(
                                          error: "Mật khẩu không hợp lệ");
                                    }
                                    return;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      addError(error: "Mật khẩu không được để trống");
                                      return "";
                                    } else if (password != value) {
                                      addError(
                                          error: 'Mật khẩu không hợp lệ');
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập lại mật khẩu',
                                    icon: Icon(Icons.lock_outline),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FormError(errors: errors),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  focusColor: Colors.blue,
                                  value: showPassword,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      showPassword = value!;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Hiện mật khẩu')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.indigo),
                              child: FlatButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    String? userId =
                                        FirebaseAuth.instance.currentUser?.uid;
                                    String? phone = FirebaseAuth
                                        .instance.currentUser?.phoneNumber;
                                    if (_authProvider.isForgot) {
                                      bool forgot =
                                          await _authProvider.forgotPassword(
                                              phone: phone!
                                                  .replaceFirst('+84', '0'),
                                              password:
                                                  rePasswordController.text,
                                              context: context);
                                      if (forgot) {
                                        locator<NavigationService>()
                                            .globalNavigateTo(
                                                LoginRoute, context);
                                      }
                                    } else {
                                      bool register =
                                          await _authProvider.registerUser(
                                              phone!.replaceFirst('+84', '0'),
                                              passwordController.text,
                                              userId!,
                                              context);
                                      if (register) {
                                        locator<NavigationService>()
                                            .globalNavigateTo(
                                                RegisterInfoRoute, context);
                                      }
                                    }
                                    log(password!);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: _authProvider.isForgot
                                            ? 'Đổi mật khẩu'
                                            : "Đăng kí",
                                        size: 22,
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Bạn đẫ có tài khoản?",
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      locator<NavigationService>()
                                          .globalNavigateTo(
                                              LoginRoute, context);
                                    },
                                    child: CustomText(
                                      text: "Đăng nhập ở đây.. ",
                                      size: 16,
                                      color: Colors.indigo,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

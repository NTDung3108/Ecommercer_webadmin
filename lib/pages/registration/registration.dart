import 'dart:developer';

import 'package:ecommerce_admin_tut/pages/register_info/register_info_page.dart';
import 'package:ecommerce_admin_tut/provider/auth.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/form_error.dart';
import 'package:ecommerce_admin_tut/widgets/loading.dart';
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
    // final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.indigo.shade600])),
      child: /*authProvider.status == Status.Authenticating
          ? Loading()
          : */
          Scaffold(
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
                      text: "REGISTRATION",
                      size: 22,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !showPassword,
                            onSaved: (newValue) => password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "Password is not empty");
                                removeError(error: "Password does not match");
                              }
                              password = value;
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "Password is not empty");
                                return "";
                              } else if (value.length < 6) {
                                addError(error: "Password too short");
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
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
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: rePasswordController,
                            obscureText: !showPassword,
                            onSaved: (newValue) => rePassword = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "Reenter is not empty");
                                removeError(error: "Password does not match");
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "Reenter is not empty");
                                return "";
                              } else if (password != value) {
                                addError(error: 'Password does not match');
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Reenter Password',
                                icon: Icon(Icons.lock_outline)),
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
                          Text('Show password')
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
                            // if (!await authProvider.signUp()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content:
                            //               Text("Registration failed!")));
                            //   return;
                            // }
                            // authProvider.clearController();
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              locator<NavigationService>()
                                  .globalNavigateTo(RegisterInfoRoute, context);
                              log(password!);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "REGISTER",
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
                            text: "Already have an account? ",
                            size: 16,
                            color: Colors.grey,
                          ),
                          GestureDetector(
                              onTap: () {
                                locator<NavigationService>()
                                    .globalNavigateTo(LoginRoute, context);
                              },
                              child: CustomText(
                                text: "Sign in here.. ",
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

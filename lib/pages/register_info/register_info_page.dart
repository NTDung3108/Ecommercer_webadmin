import 'dart:developer';

import 'package:ecommerce_admin_tut/constant.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/form_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../provider/auth.dart';
import '../../rounting/route_names.dart';
import '../../services/navigation_service.dart';

enum Gender { male, female, other }

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({Key? key}) : super(key: key);

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? address;
  String? email;

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

  Gender? _gender = Gender.male;
  String sGender = 'male';

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.indigo.shade600])),
      child: Scaffold(
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
              height: 700,
              width: 350,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "REGISTRATION INFORMATION",
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
                            controller: firstNameController,
                            onSaved: (newValue) => firstName = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "First name is not empty");
                              }
                              firstName = value;
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "First name is not empty");
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First name',
                                icon: Icon(Icons.person_outline_outlined)),
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
                            controller: lastNameController,
                            onSaved: (newValue) => lastName = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "Last name is not empty");
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "Last name is not empty");
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Last name',
                                icon: Icon(Icons.person_outline_outlined)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Radio<Gender>(
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                                sGender = 'male';
                              });
                            },
                          ),
                          Text('male'),
                          Radio<Gender>(
                            value: Gender.female,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                                sGender = 'female';
                              });
                            },
                          ),
                          Text('female'),
                          Radio<Gender>(
                            value: Gender.other,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                                sGender = 'ohter';
                              });
                            },
                          ),
                          Text('other'),
                        ],
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
                            controller: emailController,
                            onSaved: (newValue) => email = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: emailError);
                              }
                              return;
                            },
                            validator: (value) {
                              String error = checkEmail(value);
                              if (error != '') {
                                addError(error: error);
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                icon: Icon(Icons.email_outlined)),
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
                            controller: addressController,
                            onSaved: (newValue) => address = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "Address is not empty");
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "Address is not empty");
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Address',
                                icon: Icon(Icons.location_on_outlined)),
                          ),
                        ),
                      ),
                    ),
                    FormError(errors: errors),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.indigo),
                        child: FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              log(firstName! +
                                  lastName! +
                                  sGender +
                                  email! +
                                  address!);
                              String? phone = FirebaseAuth
                                  .instance.currentUser!.phoneNumber;
                              String? uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              bool registerInfo =
                                  await _authProvider.registerUserInfo(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: phone!.replaceFirst('+84', '0'),
                                      address: addressController.text,
                                      gender: sGender,
                                      email: emailController.text,
                                      uid: uid,
                                      context: context);
                              if (registerInfo)
                                locator<NavigationService>()
                                    .globalNavigateTo(LoginRoute, context);
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

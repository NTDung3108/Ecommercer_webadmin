import 'package:ecommerce_admin_tut/constant.dart';
import 'package:ecommerce_admin_tut/locator.dart';
import 'package:ecommerce_admin_tut/provider/auth.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/form_error.dart';
import 'package:ecommerce_admin_tut/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? phone;

  String? password;

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
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.status == Status.Authenticating
        ? Loading()
        : Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.indigo.shade600])),
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
                    height: 400,
                    width: 350,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "SIGN IN",
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
                                  controller: phoneController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  onSaved: (newValue) => phone = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(error: phoneNumberNullError);
                                    } else {
                                      removeError(error: phoneError);
                                    }
                                    return;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      addError(error: phoneNumberNullError);
                                      return "";
                                    }
                                    String error = checkPhone(value);
                                    if (error != '') {
                                      addError(error: error);
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Phone number',
                                      icon: Icon(Icons.phone)),
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
                                  inputFormatters: [],
                                  controller: passwordController,
                                  obscureText: !showPassword,
                                  onSaved: (newValue) => password = newValue,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      removeError(
                                          error: "password is not empty");
                                    }
                                    return;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      addError(error: "Reenter is not empty");
                                      return "";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    icon: Icon(Icons.lock_outline),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    authProvider.isForgot = true;
                                    locator<NavigationService>()
                                        .globalNavigateTo(
                                            PhoneVerifyRoute, context);
                                  },
                                  child: CustomText(
                                    text: "Forgot password?",
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
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
                          FormError(errors: errors),
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
                                  bool login = await authProvider.signIn(
                                      phoneController.text,
                                      passwordController.text,
                                      context);
                                  if (login)
                                      locator<NavigationService>()
                                          .globalNavigateTo(
                                              LayoutRoute, context);
                                  }
                                  // locator<NavigationService>()
                                  //     .globalNavigateTo(LayoutRoute, context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "SIGNIN",
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
                                      authProvider.isForgot = false;
                                      locator<NavigationService>()
                                          .globalNavigateTo(
                                              PhoneVerifyRoute, context);
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

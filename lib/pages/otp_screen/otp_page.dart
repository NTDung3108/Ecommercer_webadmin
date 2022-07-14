import 'dart:developer';
import 'package:ecommerce_admin_tut/provider/auth.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class OTPPage extends StatefulWidget {
  final bool isForgot;
  const OTPPage({Key? key, this.isForgot = false}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController  = TextEditingController();
  String? otpValue;

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
      child: Scaffold(
        key: _key,
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
                      text: "Xác Thực Số Điện Thoại",
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
                            controller: otpController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              new LengthLimitingTextInputFormatter(6)
                            ],
                            onSaved: (newValue) => otpValue = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: "Mã OTP không được để trống");
                              }
                              if(value.length == 6){
                                removeError(error: "Mã OTP không hợp lệ");
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: "mã OTP không được để trống");
                                return "";
                              }
                              if(value.length < 6){
                                addError(error: "Mã OTP không hợp lệ");
                                return "";
                              }
                              null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập mã OTP',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                              _authProvider.otp(otpController.text, context);
                              log(otpValue!);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Xác thưc",
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

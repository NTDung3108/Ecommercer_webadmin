import 'package:ecommerce_admin_tut/provider/app_provider.dart';
import 'package:ecommerce_admin_tut/provider/auth.dart';
import 'package:ecommerce_admin_tut/provider/home_provider.dart';
import 'package:ecommerce_admin_tut/provider/order_detail_provider.dart';
import 'package:ecommerce_admin_tut/provider/product_provider.dart';
import 'package:ecommerce_admin_tut/provider/statictic_provider.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/rounting/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider()),
    ChangeNotifierProvider.value(value: TablesProvider()),
    ChangeNotifierProvider.value(value: StatictisProvider()),
    ChangeNotifierProvider.value(value: OrderDetailProvider()),
    ChangeNotifierProvider.value(value: HomeProvider()),
    ChangeNotifierProvider.value(value: ProductProvider.init()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: LoginRoute,
    );
  }
}


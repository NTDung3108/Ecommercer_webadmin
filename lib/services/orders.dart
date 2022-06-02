import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_response.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';

class OrderServices {
  String collection = "orders";
  HttpClient httpClient = HttpClient();

  // Future<List<OrderModel>> getAllOrders() async =>
  //     firebaseFiretore.collection(collection).get().then((result) {
  //       List<OrderModel> orders = [];
  //       for (DocumentSnapshot order in result.docs) {
  //         orders.add(OrderModel.fromSnapshot(order));
  //       }
  //       return orders;
  //     });
  Future<List<Orders>?> getAllOrders() async {
    var response = await httpClient.get(Address.getAllOrder);
    if(response.statusCode == 200){
      return OrderResponse.fromJson(jsonDecode(response.body)).orders;
    }else{
      throw Exception();
    }
  }
  Future<List<Revenue>?> getStatistic1(int startTime, int endTime) async {
    var response = await httpClient.get('${Address.getStatistic1}?starTime=$startTime&endTime=$endTime');
    if(response.statusCode == 200){
      return RevenueStatistic.fromJson(jsonDecode(response.body)).revenue;
    }else{
      throw Exception();
    }
  }
}

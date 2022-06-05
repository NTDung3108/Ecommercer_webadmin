import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_details.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_response.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';

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
  Future<OrderDetail?> getOrderDetail(int? orderId) async {
    var response = await httpClient.get('${Address.getOrderDetail}$orderId');
    if(response.statusCode == 200){
      return OrderDetails.fromJson(jsonDecode(response.body)).orderDetail;
    }else{
      throw Exception();
    }
  }

  Future<void> downloadInvoice(int? orderId)  async {
    String url = 'http://192.168.2.101:3000/api/export_invoice/$orderId';
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}

import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_details.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_response.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'dart:html' as html;


class OrderServices {
  String collection = "orders";
  HttpClient httpClient = HttpClient();

  Future<List<Orders>?> getAllOrders() async {
    var response = await httpClient.get(Address.getAllOrder);
    if(response.statusCode == 200){
      return OrderResponse.fromJson(jsonDecode(response.body)).orders;
    }else{
      throw Exception();
    }
  }
  Future<List<Revenue>?> getRevenueStatistics(int startTime, int endTime) async {
    var response = await httpClient.get('${Address.getRevenueStatistics}?starTime=$startTime&endTime=$endTime');
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
    String url = 'http://192.168.2.151:3000/HD1.txt';
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "HD1.txt"; //in my case is .pdf
    anchorElement.click();
  }
}

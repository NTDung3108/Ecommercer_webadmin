import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_details.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_response.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'package:ecommerce_admin_tut/models/response.dart';
import 'dart:html' as html;

import 'package:ecommerce_admin_tut/services/auth_services.dart';


class OrderServices {
  HttpClient httpClient = HttpClient();

  Future<List<Orders>?> getAllOrders() async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get(Address.getAllOrder, token: token!);
    if(response.statusCode == 200){
      return OrderResponse.fromJson(jsonDecode(response.body)).orders;
    }else{
      return [];
    }
  }
  Future<List<Revenue>?> getRevenueStatistics(int startTime, int endTime) async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get('${Address.getRevenueStatistics}?starTime=$startTime&endTime=$endTime', token: token!);
    if(response.statusCode == 200){
      return RevenueStatistic.fromJson(jsonDecode(response.body)).revenue;
    }else{
      throw Exception();
    }
  }
  Future<OrderDetail?> getOrderDetail(int? orderId) async {
    var token = await AuthServices().readToken();
    var response = await httpClient.get('${Address.getOrderDetail}$orderId', token: token!);
    if(response.statusCode == 200){
      return OrderDetails.fromJson(jsonDecode(response.body)).orderDetail;
    }else{
      throw Exception();
    }
  }

  Future<Response?> updateStatus(int? orderId, int status, String reason) async {
    var token = await AuthServices().readToken();

    Map<String, dynamic> data = {
      'status': status,
      'reason': reason,
      'orderId': orderId
    };

    var body = jsonEncode(data);

    Uri uri = Uri.parse('${httpClient.server}/update-order-status');

    var resp = await httpClient.client.put(uri,
        headers: {'Content-type': 'application/json', 'xx-token': '$token'},
        body: body);

    // var response = await httpClient.put('${Address.updateOrderStatus}', token!, body);

    if(resp.statusCode == 200){
      return Response.fromJson(jsonDecode(resp.body));
    }
    if(resp.statusCode == 401){
      return Response(resp: false, msj: 'You need to login to use this function');
    }
    return null;
  }

  exportInvoice(int? orderId)async{
    // var token = await AuthServices().readToken();
    var response = await httpClient.get('${Address.downloadInvoice}$orderId');
    if(response.statusCode == 200){
      String url = 'http://192.168.2.101:3000/HD$orderId.txt';
      html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
      anchorElement.download = url;
      anchorElement.click();
      return Response.fromJson(jsonDecode(response.body));
    }else{
      // if(response.statusCode == 401 || response.statusCode == 400)
      //   return Response.fromJson(jsonDecode(response.body));
      throw Exception();
    }
  }
}

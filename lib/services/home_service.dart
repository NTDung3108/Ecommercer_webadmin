import 'dart:convert';

import 'package:ecommerce_admin_tut/address.dart';
import 'package:ecommerce_admin_tut/http_client.dart';
import 'package:ecommerce_admin_tut/models/revenue_month.dart';
import 'package:ecommerce_admin_tut/models/sum_order.dart';
import 'package:ecommerce_admin_tut/models/sum_product.dart';
import 'package:ecommerce_admin_tut/models/top_buyer.dart';

class HomeService {
  HttpClient _httpClient = HttpClient();

  Future<RevenueMonth?> getRevenueMonth(String date) async {
    var response = await _httpClient.get('${Address.revenue}?$date');
    if (response.statusCode == 200) {
      return RevenueMonth.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<SumProduct?> getSumProduct() async {
    var response = await _httpClient.get('${Address.sumProduct}');
    if (response.statusCode == 200) {
      return SumProduct.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<SumOrder?> getSumOrder(String date) async {
    var response = await _httpClient.get('${Address.sumOrder}?time=$date');
    if (response.statusCode == 200) {
      return SumOrder.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<TopBuyer?> getTopBuyer() async {
    var response = await _httpClient.get('${Address.topBuyer}');
    if (response.statusCode == 200) {
      return TopBuyer.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}

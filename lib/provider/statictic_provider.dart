import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:flutter/foundation.dart';

class StatictisProvider with ChangeNotifier{
  bool isLoading = true;
  List<Revenue> revenues = [];
  OrderServices _orderServices = OrderServices();

  getRevenue(int startTime, int endTime) async {
    isLoading = true;
    revenues = await _orderServices.getStatistic1(startTime, endTime) ?? [];
    isLoading = false;
    notifyListeners();
  }
}
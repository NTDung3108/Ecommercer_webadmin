import 'package:ecommerce_admin_tut/constant.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:flutter/foundation.dart';

class StatictisProvider with ChangeNotifier{
  bool isLoading = true;
  List<Revenue> statistics = [];
  List<double> revenues = [];
  List<String> dataX = [];
  int maxTotal = 0;
  OrderServices _orderServices = OrderServices();

  getRevenue(int startTime, int endTime) async {
    isLoading = true;
    statistics = await _orderServices.getRevenueStatistics(startTime, endTime) ?? [];
    statistics.forEach((item) {
      double revenue = item.amounts! - (item.taxs! + item.totalOriginals!) + 0.0;
      revenues.add(revenue);
      if(maxTotal < item.amounts!)
        maxTotal = item.amounts!;
    });
    isLoading = false;
    notifyListeners();
  }

  formatData(){
    int number = chartData(maxTotal);
    revenues.forEach((item) {
      double data = item / number;
      item = data;
      dataX.add(formatChartDataX(number, data.round()));
    });
    notifyListeners();
  }

}
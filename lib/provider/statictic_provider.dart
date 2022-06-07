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
    statistics.clear();
    revenues.clear();
    dataX.clear();
    isLoading = true;
    statistics = await _orderServices.getRevenueStatistics(startTime, endTime) ?? [];
    statistics.forEach((item) {
      double revenue = item.amounts! - (item.taxs! + item.totalOriginals!) + 0.0;
      revenues.add(revenue);
      if(maxTotal < revenue)
        maxTotal = revenue as int;
    });
    formatData();
    isLoading = false;
    notifyListeners();
  }

  formatData(){
    int number = chartData(maxTotal);
    revenues.sort();
    revenues.forEach((item) {
      double data = item / number;
      item = data;
    });
    double x = (maxTotal/number).ceil() / 4;
    int num = 0;
    for(int i = 1; i<5; i++){
      num = (num + x).ceil();
      dataX.add(formatChartDataX(number, num));
    }
    notifyListeners();
  }

}
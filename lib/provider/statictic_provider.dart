import 'dart:developer';
import 'package:ecommerce_admin_tut/constant.dart';
import 'package:ecommerce_admin_tut/models/order_model/revenue_statistic.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

class StatictisProvider with ChangeNotifier {
  bool isLoading = true;
  List<Revenue> statistics = [];
  List<double> revenues = [];
  List<String> dataX = [];
  int maxTotal = 0;
  List<Map<String, dynamic>> revenueTableSource = <Map<String, dynamic>>[];
  List<FlSpot> data = [];
  OrderServices _orderServices = OrderServices();

  double jump = 0;
  int index = 0;

  getRevenue(int startTime, int endTime) async {
    index = 0;
    jump = 0;
    statistics.clear();
    revenues.clear();
    dataX.clear();
    isLoading = true;
    statistics =
        await _orderServices.getRevenueStatistics(startTime, endTime) ?? [];
    revenueTableSource.addAll(_getRevenueDataTable());
    statistics.forEach((item) {
      double revenue =
          item.amounts! - (item.taxs! + item.totalOriginals!) + 0.0;
      revenues.add(revenue);
      if (maxTotal < revenue) maxTotal = revenue as int;
    });
    formatData();
    // addData();
    isLoading = false;
    notifyListeners();
  }

  formatData() {
    int number = chartData(maxTotal);
    for (int i = 0; i < revenues.length; i++) {
      double data = revenues[i] / number;
      revenues[i] = data;
    }
    double x = (maxTotal / number).ceil() / 4;
    int num = 0;
    for (int i = 1; i < 5; i++) {
      num = (num + x).ceil();
      dataX.add(formatChartDataX(number, num));
    }
    notifyListeners();
  }

  _getRevenueDataTable() {
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    for (Revenue revenue in statistics) {
      int amount = revenue.amounts ?? 0;
      int tax = revenue.taxs ?? 0;
      int totalOriginal = revenue.totalOriginals ?? 0;
      temps.add({
        "stt": i,
        "date": revenue.datee2,
        "amounts": revenue.amounts,
        "tax": revenue.taxs,
        "total_originals": revenue.totalOriginals,
        "revenue": amount - (tax + totalOriginal),
      });
      i++;
    }
    return temps;
  }

  List<FlSpot> addData() {
    data.clear();
    int length = revenues.length - 1;
    int jump = 0;
    int index = 0;
    for (int i = 1; i < 16; i++) {
      log('$i');
      if (i == 1) {
        data.add(FlSpot(i.toDouble(), revenues[index]));
        index++;
        jump = jump + (15/length).floor();
      }
      if (i > 1 && i == jump) {
        data.add(FlSpot(i.toDouble(), revenues[index]));
        index++;
        jump = jump + (15/length).floor();
      }
    }
    return data;
  }
}

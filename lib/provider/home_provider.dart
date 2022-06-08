import 'package:ecommerce_admin_tut/models/revenue_month.dart';
import 'package:ecommerce_admin_tut/models/sum_order.dart';
import 'package:ecommerce_admin_tut/models/sum_product.dart';
import 'package:ecommerce_admin_tut/models/top_buyer.dart';
import 'package:ecommerce_admin_tut/services/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  RevenueHome revenueHome = RevenueHome();
  HomeService _homeService = HomeService();
  int revenue = 0;
  int quantity = 0;
  int amount = 0;
  List<Buyers> buyers = [];

  HomeProvider.init() {
    // _getRevenue();
    getRevenueHome();
    getSumProduct();
    getSumOrder();
    getTopBuyer();
  }

  getRevenueHome() async {
    DateTime _date = DateTime.now();
    String _dateFormatted = DateFormat('yyyy-MM').format(_date);

    RevenueMonth? revenueMonth =
        await _homeService.getRevenueMonth(_dateFormatted);
    if (revenueMonth!.resp == true && revenueMonth.revenue != null) {
      revenueHome = revenueMonth.revenue!;
      revenue =
          revenueHome.amount! - revenueHome.tax! - revenueHome.totalOriginal!;
    }
    notifyListeners();
  }
  getSumProduct() async {
    SumProduct? _sumProduct = await _homeService.getSumProduct();
    if (_sumProduct!.resp == true && _sumProduct.sumProduct != null) {
      quantity = _sumProduct.sumProduct!;
    }
    notifyListeners();
  }
  getSumOrder() async {
    DateTime _date = DateTime.now();
    String _dateFormatted = DateFormat('yyyy-MM').format(_date);
    SumOrder? _sumProduct = await _homeService.getSumOrder(_dateFormatted);
    if (_sumProduct!.resp == true && _sumProduct.sumOrder != null) {
      amount = _sumProduct.sumOrder!;
    }
    notifyListeners();
  }
  getTopBuyer() async {
    TopBuyer? _topBuyer = await _homeService.getTopBuyer();
    if (_topBuyer!.resp == true && _topBuyer.buyers!.isNotEmpty == true) {
      buyers.addAll(_topBuyer.buyers!);
    }
    notifyListeners();
  }
}

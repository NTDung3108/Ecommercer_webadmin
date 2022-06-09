import 'package:ecommerce_admin_tut/helpers/enumerators.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  DisplayedPage? currentPage;
  double revenue = 0;

  AppProvider.init() {
    // _getRevenue();
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  // void _getRevenue() async {
  //   await _orderServices.getAllOrders().then((orders) {
  //     for (OrderModel order in orders) {
  //       revenue = revenue + order.total;
  //       print("======= TOTAL REVENUE: ${revenue.toString()}");
  //       print("======= TOTAL REVENUE: ${revenue.toString()}");
  //       print("======= TOTAL REVENUE: ${revenue.toString()}");
  //     }
  //     notifyListeners();
  //   });
  // }
}

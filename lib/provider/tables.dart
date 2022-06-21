import 'package:ecommerce_admin_tut/models/all_product.dart';
import 'package:ecommerce_admin_tut/models/brand_response.dart';
import 'package:ecommerce_admin_tut/models/discount_responese.dart';
import 'package:ecommerce_admin_tut/models/order_model/order_response.dart';
import 'package:ecommerce_admin_tut/services/brands.dart';
import 'package:ecommerce_admin_tut/services/discount_service.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:ecommerce_admin_tut/services/products.dart';
import 'package:ecommerce_admin_tut/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/user_response.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers
  List<Map<String, dynamic>> usersTableSource = [];
  List<Map<String, dynamic>> ordersTableSource = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> categoriesTableSource = [];
  List<Map<String, dynamic>> subcategoryTableSource = [];
  List<Map<String, dynamic>> brandsTableSource = [];
  List<Map<String, dynamic>> discountTableSource = [];

  bool isLoading = true;

  OrderServices _orderServices = OrderServices();
  List<Orders> _orders = <Orders>[];

  List<Orders> get orders => _orders;

  UserService _userServices = UserService();
  List<Users> _users = <Users>[];

  List<Users> get users => _users;


  BrandsServices _brandsServices = BrandsServices();
  List<Brands> _brands = <Brands>[];

  DiscountService _discountService = DiscountService();
  List<Discounr> _discounts = <Discounr>[];

  getOrderFromServer() async {
    ordersTableSource.clear();
    _orders.clear();
    _orders = await _orderServices.getAllOrders() ?? [];
    ordersTableSource.addAll(_getOrdersData());
    notifyListeners();
  }

  getUserFromServer() async {
    usersTableSource.clear();
    _users.clear();
    _users = await _userServices.getAllUser() ?? [];
    usersTableSource.addAll(_getUsersData());
    notifyListeners();
  }

  getBrandFromServer() async {
    brandsTableSource.clear();
    _brands.clear();
    _brands = await _brandsServices.getAllBrands() ?? [];
    brandsTableSource.addAll(_getBrandsData());
    notifyListeners();
  }

  getDiscountFromServer() async {
    discountTableSource.clear();
    _discounts.clear();
    _discounts = await _discountService.getAllDiscount() ?? [];
    discountTableSource.addAll(_getDiscountData());
    notifyListeners();
  }

  List<Map<String, dynamic>> _getUsersData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = [];
    for (Users user in _users) {
      temps.add({
        "id": user.uid,
        "name": '${user.firstName} ${user.lastName}',
        "phone": user.phone,
        "address": user.address,
        "gender": user.sex,
        "created": user.created,
        "status": user.statuss
      });
    }
    isLoading = false;
    notifyListeners();
    return temps;
  }

  List<Map<String, dynamic>> _getBrandsData() {
    List<Map<String, dynamic>> temps = [];
    for (Brands brand in _brands) {
      temps.add({
        "id": brand.idBrands,
        "brand": brand.brand,
        "status": brand.status,
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = [];
    for (Orders order in _orders) {
      temps.add({
        "id": order.uidOrderBuy,
        "userId": order.userId,
        "total": "\$${order.amount}",
        "createdAt": order.datee,
        "note": order.note,
        "reason": order.reason ?? '',
        "status": order.status
      });
    }
    return temps;
  }


  List<Map<String, dynamic>> _getDiscountData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = [];
    for (Discounr discount in _discounts) {
      temps.add({
        "id": discount.idDiscount,
        "title": discount.title,
        "content": discount.content,
        "startday": discount.startTime,
        "endday": discount.endTime,
      });
    }
    return temps;
  }
}

import 'package:ecommerce_admin_tut/models/order_model/order_details.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class OrderDetailProvider with ChangeNotifier{
  bool isLoading = true;
  OrderServices _services = OrderServices();

  List<Map<String, dynamic>> orderDetailTableSource = <Map<String, dynamic>>[];
  OrderDetail orderDetail = OrderDetail();
  List<Details> _detail = <Details>[];


  getOrderDetail(int orderId) async {
    try{
      _detail.clear();
      orderDetail = await _services.getOrderDetail(orderId) ?? orderDetail;
      _detail.addAll(orderDetail.details ?? []);
      orderDetailTableSource.clear();
      orderDetailTableSource.addAll(_getOrderDetailData());
    }catch(e){
      throw Exception(e);
    }
    notifyListeners();
  }

  _getOrderDetailData(){
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    for (Details detail in _detail) {
      temps.add({
        "stt": i,
        "nameProduct": detail.nameProduct,
        "quantity": detail.quantity,
        "price": detail.price,
      });
      i++;
    }
    return temps;
  }

  downloadInvoice(int? orderId, BuildContext context)async{
    var res = await _services.exportInvoice(orderId);
    if(res.resp){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${res.msj}'),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${res.msj}'),
        ),
      );
    }
  }

  updateOrderStatus(int orderId, int status, String reason, BuildContext context) async{
    try{
      var resp = await _services.updateStatus(orderId, status, reason);
      if(resp!.resp!){
        orderDetail.status = status;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${resp.msj}'),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${resp.msj}'),
          ),
        );
      }
    }catch(e){
      throw Exception(e);
    }
    notifyListeners();
  }
}
import 'package:ecommerce_admin_tut/models/order_model/order_details.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../address.dart';

class OrderDetailProvider with ChangeNotifier{
  bool isLoading = false;
  OrderServices _services = OrderServices();

  List<Map<String, dynamic>> orderDetailTableSource = <Map<String, dynamic>>[];
  OrderDetail orderDetail = OrderDetail();
  List<Details> _detail = <Details>[];


  getOrderDetail(int orderId) async {
    isLoading = true;
    try{
      orderDetail = await _services.getOrderDetail(orderId) ?? orderDetail;
      _detail.addAll(orderDetail.details ?? []);
      orderDetailTableSource.addAll(_getOrderDetailData());
      isLoading = false;
      notifyListeners();
    }catch(e){
      throw Exception(e);
    }
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

  downloadInvoice()async{
    String url = '${Address.downloadInvoice}${orderDetail.orderId}';

    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
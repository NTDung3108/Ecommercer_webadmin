import 'package:ecommerce_admin_tut/models/info_staff_response.dart';
import 'package:ecommerce_admin_tut/services/user_services_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StaffProvider extends ChangeNotifier {
  Information? info;

  StaffProvider.init() {
    getInfoStaff();
  }

  void getInfoStaff() async {
    final sercureStorage = FlutterSecureStorage();
    var sid = await sercureStorage.read(key: 'sid');
    try {
      var resp = await UserServices2.getInfomationStaff(sid: sid!);
      if (resp!.resp!) {
        info = resp.information!;
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }
}

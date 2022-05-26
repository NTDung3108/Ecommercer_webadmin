import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String? _id;
  String? _description;
  String? _userId;
  String? _status;
  int? _createdAt;
  double? _total;

//  getters
  String get id => _id!;

  String get description => _description!;

  String get userId => _userId!;

  String get status => _status!;

  double get total => _total!;

  int get createdAt => _createdAt!;

  // public variable
  List? cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _description = snapshot[DESCRIPTION];
    _total = snapshot[TOTAL];
    _status = snapshot[STATUS];
    _userId = snapshot[USER_ID];
    _createdAt = snapshot[CREATED_AT];
    cart = snapshot[CART];
  }
}

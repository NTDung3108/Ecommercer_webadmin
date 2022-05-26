import 'package:ecommerce_admin_tut/models/routing_data.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print(
        'queryParameters: ${uriData.queryParameters} path: ${uriData.path}'); // remove later
    return RoutingData(
        queryParameters: uriData.queryParameters, route: '$uriData');
  }
}

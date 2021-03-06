import 'package:ecommerce_admin_tut/provider/app_provider.dart';
import 'package:ecommerce_admin_tut/provider/home_provider.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_item.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
    return Container(
      height: 120,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardItem(
              icon: Icons.monetization_on_outlined,
              title: "Revenue",
              subtitle: "Revenue this month",
              value: "\$ ${_homeProvider.revenue}",
              color1: Colors.green.shade700,
              color2: Colors.green,
            ),
            CardItem(
              icon: Icons.shopping_basket_outlined,
              title: "Products",
              subtitle: "Total products on store",
              value: "${_homeProvider.quantity}",
              color1: Colors.lightBlueAccent,
              color2: Colors.blue,
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "Orders",
              subtitle: "Total orders for this month",
              value: "${_homeProvider.amount}",
              color1: Colors.redAccent,
              color2: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

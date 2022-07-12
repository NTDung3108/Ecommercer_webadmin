import 'package:ecommerce_admin_tut/widgets/cards/card_item.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:ecommerce_admin_tut/widgets/charts/sales_chart.dart';
import 'package:ecommerce_admin_tut/widgets/top_buyer.dart';
import 'package:flutter/material.dart';

class HomePageTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(
          text: 'Bảng Điều Khiển',
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CardItem(
            icon: Icons.monetization_on_outlined,
            title: "Doanh thu",
            subtitle: "Doanh thu trong tháng",
            value: "\$ 4,323",
            color1: Colors.green.shade700,
            color2: Colors.green,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CardItem(
            icon: Icons.shopping_basket_outlined,
            title: "Sản phẩm",
            subtitle: "Số lượng sản phẩm trong kho",
            value: "231",
            color1: Colors.lightBlueAccent,
            color2: Colors.blue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CardItem(
            icon: Icons.delivery_dining,
            title: "Đơn hàng",
            subtitle: "Số lượn đơn hàng trong tháng",
            value: "33",
            color1: Colors.redAccent,
            color2: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 1.19,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.19,
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300]!,
                          offset: Offset(0, 3),
                          blurRadius: 16)
                    ]),
                child: Column(
                  children: [
                    CustomText(
                      text: 'bảng xếp hạng',
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

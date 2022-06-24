import 'package:ecommerce_admin_tut/models/top_buyer.dart';
import 'package:ecommerce_admin_tut/models/top_products.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class TopProductWidget extends StatelessWidget {
  TopProduct topProduct;
  TopProductWidget({required this.topProduct});
  @override
  Widget build(BuildContext context) {
    return topProduct.picture![0].isEmpty == true ? ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('images/profile.jpg'),
      ),
      title: Text('${topProduct.nameProduct}'),
      subtitle: Text('${topProduct.sold}, products'),
      trailing: CustomText(
        text: '${topProduct.price! * topProduct.sold!} VND',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    ) : ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: ClipOval(
          child: Image.network('http://192.168.2.101:3000/${topProduct.picture![0]}'),
        ),
      ),
      title: Text('${topProduct.nameProduct}'),
      subtitle: Text('${topProduct.sold}, products'),
      trailing: CustomText(
        text: '${topProduct.price! * topProduct.sold!} VND',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    );
  }
}

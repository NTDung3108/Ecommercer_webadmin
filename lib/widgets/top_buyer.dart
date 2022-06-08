import 'package:ecommerce_admin_tut/models/top_buyer.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class TopBuyerWidget extends StatelessWidget {
  Buyers buyers;
  TopBuyerWidget({required this.buyers});
  @override
  Widget build(BuildContext context) {
    return buyers.image!.isEmpty == true ? ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('images/profile.jpg'),
      ),
      title: Text('${buyers.firstName} ${buyers.lastName}'),
      subtitle: Text('${buyers.numberOfOrder}, orders'),
      trailing: CustomText(
        text: '${buyers.amount} VND',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    ) : ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: ClipOval(
          child: Image.network('http://10.50.10.135:3000/${buyers.image}'),
        ),
      ),
      title: Text('${buyers.firstName} ${buyers.lastName}'),
      subtitle: Text('${buyers.numberOfOrder}, orders'),
      trailing: CustomText(
        text: '${buyers.amount} VND',
        color: Colors.green.shade800,
        weight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/base_appbar.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        context: context,
        title: 'Order Detail',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowItem('Name'),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Price'),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Import Price'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Discount: ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Quantity'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Sold: ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Color'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Brand: ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Category: ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Add Day'),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Update Day'),
                const SizedBox(
                  height: 10,
                ),
                descriptionItem('Description'),
                // Text(
                //   'Description: ',
                //   style: TextStyle(fontSize: 16, color: Colors.black),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Picture: ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Giao hàng'),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem(String title) {
    return Row(
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        IntrinsicWidth(
          child: TextFormField(
            controller: phoneController,
            onSaved: (newValue) => phone = newValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone number',
            ),
          ),
        ),
      ],
    );
  }

  Widget descriptionItem(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1 / 3,
          height: 100,
          child: TextFormField(
            onSaved: (newValue) => phone = newValue,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Phone number',
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:html';

import 'package:ecommerce_admin_tut/models/brand_response.dart';
import 'package:ecommerce_admin_tut/models/discount_responese.dart';
import 'package:ecommerce_admin_tut/models/subcategory.dart';
import 'package:ecommerce_admin_tut/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/base_appbar.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  List<String> data = ['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
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
                rowItem('Name', _productProvider.nameController),
                // const SizedBox(
                //   height: 10,
                // ),
                rowItem('Price', _productProvider.priceController),
                // const SizedBox(
                //   height: 10,
                // ),
                rowItem('Import Price', _productProvider.importPriceController),
                // const SizedBox(
                //   height: 10,
                // ),
                // rowDropdownDiscount('Discount', _productProvider.discount),
                discountItem('Discount', _productProvider.discount,
                    _productProvider.product.discount!),
                // const SizedBox(
                //   height: 10,
                // ),
                rowItem('Quantity', _productProvider.quantityController),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Sold: ${_productProvider.product.sold} ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Color', _productProvider.colorController),
                // const SizedBox(
                //   height: 10,
                // ),
                brandsItem('Brands', _productProvider.brands,
                    _productProvider.product.brandsId!),
                // const SizedBox(
                //   height: 10,
                // ),
                categoryItem('Category', _productProvider.subcategories,
                    _productProvider.product.subcategoryId!),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Day: ${_productProvider.product.addDay}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Update Day: ${_productProvider.product.updateday}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                descriptionItem(
                    'Description', _productProvider.descriptionController),
                const SizedBox(
                  height: 10,
                ),
                pictureRow('Picture', _productProvider.product.picture!),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Cập nhật'),
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

  Widget rowItem(String title, TextEditingController controller) {
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
            controller: controller,
            onSaved: (newValue) => phone = newValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '$title',
            ),
          ),
        ),
      ],
    );
  }

  Widget descriptionItem(String title, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 9,
            ),
            Text(
              '$title:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1 / 3,
          height: 100,
          child: TextFormField(
            controller: controller,
            onSaved: (newValue) => phone = newValue,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              hintText: '$title',
            ),
          ),
        ),
      ],
    );
  }

  Widget discountItem(String title, List<Discounr> data, int discount) {
    List<String> list =
        data.map((e) => '${e.idDiscount}-${e.discount}%').toList();
    String dropdownValue = list.where((e) => e[0] == '$discount').toList()[0];
    return Row(
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget brandsItem(String title, List<Brands> data, int id) {
    List<String> list = data.map((e) => '${e.idBrands}-${e.brand}').toList();
    String dropdownValue = list.where((e) => e[0] == '$id').toList()[0];
    return Row(
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget categoryItem(String title, List<Subcategory> data, int id) {
    List<String> list = data.map((e) => '${e.id}-${e.name}').toList();
    String dropdownValue = list.where((e) => e[0] == '$id').toList()[0];
    return Row(
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 10,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget pictureRow(String title, List<String> data) {
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
          width: MediaQuery.of(context).size.width * 2 / 3,
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network('http://10.50.10.135:3000/${data[index]}'));
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
          ),
        ),
      ],
    );
  }
}

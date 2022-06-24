import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:ecommerce_admin_tut/models/brand_response.dart';
import 'package:ecommerce_admin_tut/models/discount_responese.dart';
import 'package:ecommerce_admin_tut/models/subcategory.dart';
import 'package:ecommerce_admin_tut/provider/product_provider.dart';
import 'package:ecommerce_admin_tut/widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({Key? key}) : super(key: key);

  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> files = [];
  List<Uint8List> images = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController importPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String discountValue = '';
  String brandValue = '';
  String categoryValue = '';

  @override
  Widget build(BuildContext context) {
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: BaseAppbar(
        context: context,
        title: 'New Product',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowItem('Name', nameController),
                rowItem('Price', priceController),
                rowItem('Import Price', importPriceController),
                discountItem('Discount', _productProvider.discount),
                rowItem('Quantity', quantityController),
                const SizedBox(
                  height: 10,
                ),
                rowItem('Color', colorController),
                brandsItem('Brands', _productProvider.brands),
                categoryItem('Category', _productProvider.subcategories),
                const SizedBox(
                  height: 20,
                ),
                descriptionItem('Description', descriptionController),
                const SizedBox(
                  height: 10,
                ),
                pictureRow('Picture', images),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        int discount = discountValue.isEmpty
                            ? _productProvider.discount[0].idDiscount!
                            : int.parse(discountValue[0]);
                        int brand = brandValue.isEmpty
                            ? _productProvider.brands[0].idBrands!
                            : int.parse(brandValue[0]);
                        int subcategory = categoryValue.isEmpty
                            ? _productProvider.subcategories[0].id!
                            : int.parse(categoryValue[0]);
                        _productProvider.addNewProduct(
                            images,
                            files,
                            nameController.text,
                            descriptionController.text,
                            int.parse(priceController.text),
                            discount,
                            int.parse(quantityController.text),
                            jsonEncode(colorController.text.split(', ')),
                            brand,
                            subcategory,
                            int.parse(importPriceController.text),
                            context);
                      },
                      child: Text('Thêm Sản Phẩm'),
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
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
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

  Widget discountItem(String title, List<Discounr> data) {
    List<String> list =
        data.map((e) => '${e.idDiscount}-${e.discount}%').toList();
    String s = list[0];
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
          value: discountValue.isEmpty ? s : discountValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              discountValue = value!;
            });
          },
        ),
      ],
    );
  }

  Widget brandsItem(String title, List<Brands> data) {
    List<String> list = data.map((e) => '${e.idBrands}-${e.brand}').toList();
    String s = list[0];
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
          value: brandValue.isEmpty ? s : brandValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              brandValue = value!;
            });
          },
        ),
      ],
    );
  }

  Widget categoryItem(String title, List<Subcategory> data) {
    List<String> list = data.map((e) => '${e.id}-${e.name}').toList();
    String s = list[0];
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
          value: categoryValue.isEmpty ? s : categoryValue,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              categoryValue = value!;
            });
          },
        ),
      ],
    );
  }

  Widget pictureRow(String title, List<dynamic> data) {
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
            itemCount: data.isEmpty ? 1 : data.length + 1,
            itemBuilder: (context, index) {
              if (data.isNotEmpty)
                return index == data.length
                    ? SizedBox()
                    : SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.memory(images[index]),
                      );
              return InkWell(
                onTap: () async {
                  var image =
                      await ImagePickerPlugin().getMultiImage(imageQuality: 5);
                  var i_1 = await image[0].readAsBytes();
                  var i_2 = await image[1].readAsBytes();
                  var i_3 = await image[2].readAsBytes();
                  var i_4 = await image[3].readAsBytes();
                  var i_5 = await image[4].readAsBytes();
                  var img = [i_1, i_2, i_3, i_4, i_5];

                  setState(() {
                    images.addAll(img);
                    for (int i = 0; i < image.length; i++) {
                      files.add(image[i].name);
                      log(files[index]);
                    }
                  });
                },
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('images/add_image.png'),
                ),
              );
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

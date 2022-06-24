import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:ecommerce_admin_tut/locator.dart';
import 'package:ecommerce_admin_tut/models/all_product.dart';
import 'package:ecommerce_admin_tut/models/brand_response.dart';
import 'package:ecommerce_admin_tut/models/detail_product.dart';
import 'package:ecommerce_admin_tut/models/discount_responese.dart';
import 'package:ecommerce_admin_tut/models/subcategory.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/brands.dart';
import 'package:ecommerce_admin_tut/services/categories.dart';
import 'package:ecommerce_admin_tut/services/discount_service.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/services/products.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProductProvider extends ChangeNotifier {
  DiscountService _discountService = DiscountService();
  BrandsServices _brandsServices = BrandsServices();
  CategoriesServices _categoriesServices = CategoriesServices();

  List<Map<String, dynamic>> productsTableSource = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> source = [];

  ProductsServices _productsServices = ProductsServices();
  List<Products> _products = <Products>[];

  List<Products> get products => _products;

  List<int> perPages = [];
  int total = 100;
  int currentPerPage = 5;
  int currentPage = 1;
  bool isSearch = false;
  String? searchKey = "name";
  List<bool>? expanded = [];

  List<Map<String, dynamic>> selecteds = [];
  String selectableKey = "id";

  String? sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  Product product = Product();
  List<Discounr> discount = [];
  List<Brands> brands = [];
  List<Subcategory> subcategories = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController importPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String discountValue = '';

  late List<DatatableHeader> headers = headers = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 3,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Brand",
        value: "brand",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Sold",
        value: "sold",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Import Price",
        value: "importPrice",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Add Day",
        value: "addDay",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Update Day",
        value: "updateDay",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
      text: "",
      value: "delete",
      show: true,
      sortable: false,
      sourceBuilder: (value, row) {
        return InkWell(
          onTap: () {
            log('${row["id"]}');
            deleteProduct(row["id"]);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    )
  ];

  init() {
    getListBrand();
    getListDiscount();
    getListSubcategory();
  }

  getProductFromServer() async {
    productsTableSource.clear();
    _products.clear();
    perPages.clear();
    _products = await _productsServices.getAllProducts() ?? [];
    productsTableSource.addAll(_getProductsData());
    sourceFiltered = productsTableSource;
    total = sourceFiltered.length;
    if (_products.length < 5) {
      currentPerPage = _products.length;
      expanded = List.generate(currentPerPage, (index) => false);
      source = sourceFiltered.getRange(0, currentPerPage).toList();
    } else {
      currentPerPage = 5;
      perPages.addAll([5, 10, 15, 100]);
      expanded = List.generate(currentPerPage, (index) => false);
      source = sourceFiltered.getRange(0, currentPerPage).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = [];
    for (Products product in _products) {
      temps.add({
        "id": product.idProduct,
        "name": product.nameProduct,
        "brand": product.brand,
        "category": product.name,
        "quantity": product.quantily,
        "sold": product.sold,
        "price": "${product.price} VND",
        "importPrice": '${product.importPrice} VND',
        "addDay": product.addDay,
        "updateDay": product.updateDay,
      });
    }
    return temps;
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      productsTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      productsTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      selecteds = productsTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    var _nextSet = currentPage - currentPerPage;
    currentPage = _nextSet > 1 ? _nextSet : 1;
    resetData(start: currentPage - 1);
    notifyListeners();
  }

  resetData({start: 0}) async {
    isLoading = true;
    notifyListeners();
    var _expandedLen =
        total - start < currentPerPage ? total - start : currentPerPage;
    Future.delayed(Duration(seconds: 0)).then((value) {
      expanded = List.generate(_expandedLen as int, (index) => false);
      source.clear();
      source = sourceFiltered.getRange(start, start + _expandedLen).toList();
      isLoading = false;
      notifyListeners();
    });
  }

  next() {
    var _nextSet = currentPage + currentPerPage;
    currentPage = _nextSet < total ? _nextSet : total - currentPerPage;
    resetData(start: _nextSet - 1);
    notifyListeners();
  }

  filterData(value) {
    isLoading = true;
    notifyListeners();
    try {
      if (value == "" || value == null) {
        sourceFiltered = productsTableSource;
      } else {
        sourceFiltered = productsTableSource
            .where((data) => data[searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      total = sourceFiltered.length;
      var _rangeTop = total < currentPerPage ? total : currentPerPage;
      expanded = List.generate(_rangeTop, (index) => false);
      source = sourceFiltered.getRange(0, _rangeTop).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  getDetailProduct(int id, BuildContext context) async {
    String color = '';
    try {
      var resp = await _productsServices.getDetailProducts(id);
      if (resp!.resp!) {
        product = resp.product!;
        nameController.text = product.nameProduct!;
        priceController.text = '${product.price ?? 0}';
        importPriceController.text = '${product.importPrice ?? 0}';
        quantityController.text = '${product.quantily ?? 0}';
        for (int i = 0; i < product.colors!.length; i++) {
          if (i == product.colors!.length - 1) {
            color = color + product.colors![i];
          } else {
            color = color + product.colors![i] + ', ';
          }
        }
        colorController.text = color;
        descriptionController.text = product.description ?? '';
        locator<NavigationService>()
            .globalNavigateTo(ProductDetailRoute, context);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  getListDiscount() async {
    discount.clear();
    try {
      var resp = await _discountService.getAllDiscount();
      if (resp!.isNotEmpty == true) discount.addAll(resp);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  getListBrand() async {
    brands.clear();
    try {
      var resp = await _brandsServices.getAllBrands();
      if (resp!.isNotEmpty == true) brands.addAll(resp);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  getListSubcategory() async {
    subcategories.clear();
    try {
      var resp = await _categoriesServices.getAllSubcategory();
      if (resp!.isNotEmpty == true) subcategories.addAll(resp);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  updateProduct(
      int discount, int brand, int subcategory, BuildContext context) async {
    try {
      var resp = await _productsServices.updateProduct(
          product.idProduct!,
          nameController.text,
          descriptionController.text,
          int.parse(priceController.text),
          discount,
          int.parse(quantityController.text),
          jsonEncode(colorController.text.split(', ')),
          brand,
          subcategory,
          int.parse(importPriceController.text));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(resp.msj ?? ''),
      ));
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteProduct(int id) async {
    try {
      var resp = await _productsServices.deleteProduct(id);
      if (resp.resp!) {
        getProductFromServer();
      }
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  Future<bool> addNewProduct(
      List<Uint8List> image,
      List<String> fileName,
      String name,
      String description,
      int price,
      int discount,
      int quantity,
      String colors,
      int brand,
      int subcategory,
      int importPrice,
      BuildContext context) async {

    // var file1 = http.MultipartFile.fromBytes('many-files', image[0],
    //           filename: fileName[0],
    //           contentType: new MediaType("image", 'jpg'));
    // var file2 = http.MultipartFile.fromBytes('many-files', image[1],
    //     filename: fileName[1],
    //     contentType: new MediaType("image", 'jpg'));
    // var file3 = http.MultipartFile.fromBytes('many-files', image[2],
    //     filename: fileName[2],
    //     contentType: new MediaType("image", 'jpg'));
    // var file4 = http.MultipartFile.fromBytes('many-files', image[3],
    //     filename: fileName[3],
    //     contentType: new MediaType("image", 'jpg'));
    // var file5 = http.MultipartFile.fromBytes('many-files', image[4],
    //     filename: fileName[4],
    //     contentType: new MediaType("image", 'jpg'));
    // var multiFile = [file1, file2, file3, file4, file5];
    try {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resp.msj ?? ''),
        ),
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}

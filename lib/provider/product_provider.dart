import 'package:ecommerce_admin_tut/locator.dart';
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
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  ProductsServices _productsServices = ProductsServices();
  DiscountService _discountService = DiscountService();
  BrandsServices _brandsServices = BrandsServices();
  CategoriesServices _categoriesServices = CategoriesServices();

  List<Map<String, dynamic>> productsTableSource = [];

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

  ProductProvider.init() {
    getListBrand();
    getListDiscount();
    getListSubcategory();
  }

  getDetailProduct(int id, BuildContext context) async {
    String color = '';
    try {
      var resp = await _productsServices.getDetailProducts(id);
      if (resp!.resp!) {
        product = resp.product!;
        nameController.text = product.nameProduct!;
        priceController.text = '${product.price ?? 0}';
        importPriceController.text = '${product.price ?? 0}';
        quantityController.text = '${product.quantily ?? 0}';
        for (int i = 0; i < product.colors!.length; i++) {
          color = color + product.colors![i];
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
}

import 'package:ecommerce_admin_tut/locator.dart';
import 'package:ecommerce_admin_tut/provider/product_provider.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("SẢN PHẨM"),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  title: TextButton.icon(
                    onPressed: (){
                      locator<NavigationService>()
                          .globalNavigateTo(NewProductRoute, context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Thêm mới"),
                  ),
                  actions: [
                    if (productProvider.isSearch)
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nhập từ khóa cần tìm kiếm' +
                                productProvider.searchKey!
                                    .replaceAll(new RegExp('[\\W_]+'), ' ')
                                    .toUpperCase(),
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    productProvider.isSearch = false;
                                  });
                                  productProvider.getProductFromServer();
                                }),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                          ),
                          onSubmitted: (value) {
                            productProvider.filterData(value);
                          },
                        ),
                      ),
                    if (!productProvider.isSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              productProvider.isSearch = true;
                            });
                          })
                  ],
                  headers: productProvider.headers,
                  source: productProvider.source,
                  expanded: productProvider.expanded,
                  selecteds: productProvider.selecteds,
                  showSelect: productProvider.showSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                    productProvider.getDetailProduct(data['id'], context);
                  },
                  onSort: productProvider.onSort,
                  sortAscending: productProvider.sortAscending,
                  sortColumn: productProvider.sortColumn,
                  isLoading: productProvider.isLoading,
                  onSelect: (value, item) =>
                      productProvider.onSelected(value!, item),
                  onSelectAll: (value) => productProvider.onSelectAll(value!),
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Số hàng:"),
                    ),
                    if (productProvider.perPages.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton<int>(
                          value: productProvider.currentPerPage,
                          items: productProvider.perPages
                              .map((e) => DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (dynamic value) {
                            productProvider.currentPerPage = value;
                            productProvider.currentPage = 1;
                            productProvider.resetData();
                          },
                          isExpanded: false,
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "${productProvider.currentPage} - ${productProvider.currentPage} of ${productProvider.total}"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: productProvider.currentPage == 1
                          ? null
                          : () => productProvider.previous,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: productProvider.currentPage +
                                  productProvider.currentPerPage -
                                  1 >=
                              productProvider.total
                          ? null
                          : () => productProvider.next,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productProvider.getProductFromServer(),
        child: Icon(Icons.refresh_sharp),
      ),
    );
  }
}

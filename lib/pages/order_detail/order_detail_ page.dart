import 'dart:math';

import 'package:ecommerce_admin_tut/widgets/base_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late List<DatatableHeader> _headers;

  int? _currentPerPage = 6;
  List<bool>? _expanded;


  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  String _selectableKey = "id";

  bool _sortAscending = true;
  bool _isLoading = true;

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    print(i);
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "stt": i,
        "nameProduct": "$i\000$i",
        "quantity": "Product $i",
        "price": "Category-$i",
      });
      i++;
    }
    return temps;
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_generateData(n: 6));
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _headers = [
      DatatableHeader(
          text: "STT",
          value: "stt",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Name Product",
          value: "nameProduct",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Quantity",
          value: "quantity",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
    ];
    _mockPullData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        context: context,
        title: 'Order Detail',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Address: ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phone: ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 3,
                width: MediaQuery.of(context).size.width * 4 / 5,
                child: ResponsiveDatatable(
                  title: Text('Danh sách sản phẩm'),
                  reponseScreenSizes: [ScreenSize.xs],
                  headers: _headers,
                  source: _sourceOriginal,
                  selecteds: _selecteds,
                  showSelect: false,
                  autoHeight: false,
                  expanded: _expanded,
                  sortAscending: _sortAscending,
                  isLoading: _isLoading,
                  // footers: [
                  //   Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child: Text("Rows per page:"),
                  //   ),
                  //   if (_perPages.isNotEmpty)
                  //     Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 15),
                  //       child: DropdownButton<int>(
                  //         value: _currentPerPage,
                  //         items: _perPages
                  //             .map((e) => DropdownMenuItem<int>(
                  //           child: Text("$e"),
                  //           value: e,
                  //         ))
                  //             .toList(),
                  //         onChanged: (dynamic value) {
                  //           // _tablesProvider!.onChanged(value);
                  //           setState(() {
                  //             _currentPerPage = value;
                  //             _currentPage = 1;
                  //             _resetData();
                  //           });
                  //         },
                  //         isExpanded: false,
                  //       ),
                  //     ),
                  //   Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child:
                  //     Text("$_currentPage - $_currentPerPage of $_total"),
                  //   ),
                  //   IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back_ios,
                  //       size: 16,
                  //     ),
                  //     onPressed: _currentPage == 1
                  //         ? null
                  //         : () {
                  //       var _nextSet = _currentPage - _currentPerPage!;
                  //       setState(() {
                  //         _currentPage = _nextSet > 1 ? _nextSet : 1;
                  //         _resetData(start: _currentPage - 1);
                  //       });
                  //     },
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //   ),
                  //   IconButton(
                  //     icon: Icon(Icons.arrow_forward_ios, size: 16),
                  //     onPressed: _currentPage + _currentPerPage! - 1 >= _total
                  //         ? null
                  //         : () {
                  //       var _nextSet = _currentPage + _currentPerPage!;
                  //
                  //       setState(() {
                  //         _currentPage = _nextSet < _total
                  //             ? _nextSet
                  //             : _total - _currentPerPage!;
                  //         _resetData(start: _nextSet - 1);
                  //       });
                  //     },
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //   )
                  // ],
                ),
                // child: ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (BuildContext context, int index) {
                //     return ListTile(
                //         leading: Icon(Icons.list),
                //         trailing: Text(
                //           "GFG",
                //           style: TextStyle(color: Colors.green, fontSize: 15),
                //         ),
                //         title: Text("List item $index"));
                //   },
                // ),
              ),
              SizedBox(height:20,),
              Text("Amount: ",style: TextStyle(fontSize: 16, color: Colors.black)),
              SizedBox(height:20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Xuất hóa đơn'),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Giao hàng'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green
                        ),
                      ),
                      SizedBox(width:20,),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Hủy đơn hàng'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:ecommerce_admin_tut/widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../provider/order_detail_provider.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  OrderDetailProvider? _orderDetailProvider;

  late List<DatatableHeader> _headers;

  int? _currentPerPage = 10;
  List<bool>? _expanded;

  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _selecteds = [];

  // ignore: unused_field
  String _selectableKey = "id";

  bool _sortAscending = true;
  bool _isLoading = true;

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_orderDetailProvider!.orderDetailTableSource);
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
    Future.delayed(Duration.zero, () {
      _orderDetailProvider =
          Provider.of<OrderDetailProvider>(context, listen: false);
      _mockPullData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        context: context,
        title: 'Order Detail',
      ),
      body: _orderDetailProvider!.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${_orderDetailProvider!.orderDetail.userName}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Address: ${_orderDetailProvider!.orderDetail.address}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone: ${_orderDetailProvider!.orderDetail.phone}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _orderDetailProvider!.orderDetail.status != -1
                        ? Text(
                            'Note: ${_orderDetailProvider!.orderDetail.note}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        : Text(
                            'Reason: ${_orderDetailProvider!.orderDetail.reason}',
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Amount: ${_orderDetailProvider!.orderDetail.amount} VND",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    if (_orderDetailProvider!.orderDetail.status != -1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _orderDetailProvider!.downloadInvoice(
                                  _orderDetailProvider!.orderDetail.orderId,
                                  context);
                            },
                            child: Text('Xuất hóa đơn'),
                          ),
                          if (_orderDetailProvider!.orderDetail.status! < 2)
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _orderDetailProvider!.updateOrderStatus(
                                        _orderDetailProvider!.orderDetail.orderId!,
                                        1, '', context);
                                  },
                                  child: Text('Giao hàng'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _orderDetailProvider!.updateOrderStatus(
                                        _orderDetailProvider!.orderDetail.orderId!,
                                        -1, '', context);
                                  },
                                  child: Text('Hủy đơn hàng'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
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

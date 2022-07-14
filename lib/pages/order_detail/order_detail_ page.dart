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

  late List<DatatableHeader> _headers;

  int? _currentPerPage = 10;
  List<bool>? _expanded;

  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _selecteds = [];

  // ignore: unused_field
  String _selectableKey = "id";

  bool _sortAscending = true;
  bool _isLoading = true;

  // _mockPullData() async {
  //   _expanded = List.generate(_currentPerPage!, (index) => false);
  //
  //   setState(() => _isLoading = true);
  //   Future.delayed(Duration(seconds: 3)).then((value) {
  //     _sourceOriginal.clear();
  //     _sourceOriginal.addAll(_orderDetailProvider!.orderDetailTableSource);
  //     setState(() => _isLoading = false);
  //   });
  // }

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
          text: "Tên sản phẩm",
          value: "nameProduct",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Số lượng",
          value: "quantity",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Đơn giá",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
    ];
    // Future.delayed(Duration.zero, () {
    //   // _orderDetailProvider =
    //   //     Provider.of<OrderDetailProvider>(context, listen: false);
    //   _mockPullData();
    // });
    // _expanded = List.generate(_currentPerPage!, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderDetailProvider? _orderDetailProvider = Provider.of<OrderDetailProvider>(context);
    // _mockPullData() async {
    //   _expanded = List.generate(_currentPerPage!, (index) => false);
    //
    //   setState(() => _isLoading = true);
    //   Future.delayed(Duration(seconds: 3)).then((value) {
    //     _sourceOriginal.clear();
    //     _sourceOriginal.addAll(_orderDetailProvider!.orderDetailTableSource);
    //     setState(() => _isLoading = false);
    //   });
    // }
    return Scaffold(
      appBar: BaseAppbar(
        context: context,
        title: 'Chi tiết đơn hàng',
      ),
      body: _orderDetailProvider.orderDetail == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên: ${_orderDetailProvider.orderDetail.userName ?? ''}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Địa chỉ: ${_orderDetailProvider.orderDetail.address ?? ''}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Số điện thoại: ${_orderDetailProvider.orderDetail.phone ?? ''}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _orderDetailProvider.orderDetail.status != -1
                        ? Text(
                            'Ghi chú: ${_orderDetailProvider.orderDetail.note}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        : Text(
                            'Lí do: ${_orderDetailProvider.orderDetail.reason}',
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
                        source: _orderDetailProvider.orderDetailTableSource,
                        selecteds: _selecteds,
                        showSelect: false,
                        autoHeight: false,
                        expanded: List.generate(_currentPerPage!, (index) => false),
                        sortAscending: _sortAscending,
                        // isLoading: _isLoading,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Tổng giá: ${_orderDetailProvider.orderDetail.amount} VND",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    if (_orderDetailProvider.orderDetail.status != -1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _orderDetailProvider.downloadInvoice(
                                  _orderDetailProvider.orderDetail.orderId,
                                  context);
                            },
                            child: Text('Xuất hóa đơn'),
                          ),
                          if (_orderDetailProvider.orderDetail.status != 2)
                            Row(
                              children: [
                                if (_orderDetailProvider.orderDetail.status !=
                                    1)
                                  ElevatedButton(
                                    onPressed: () {
                                      _orderDetailProvider.updateOrderStatus(
                                          _orderDetailProvider.orderDetail.orderId!,
                                          1,
                                          '',
                                          context);
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
                                    _orderDetailProvider.updateOrderStatus(
                                        _orderDetailProvider.orderDetail.orderId!,
                                        -1,
                                        '',
                                        context);
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
      // body: ChangeNotifierProvider<OrderDetailProvider>(
      //   create: (context) => OrderDetailProvider(),
      //   child: Consumer<OrderDetailProvider>(
      //     builder: (context, odprovider, child) {
      //       if (odprovider.isLoading)
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       return Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      //         child: SingleChildScrollView(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'Name: ${odprovider.orderDetail.userName}',
      //                 style: TextStyle(fontSize: 16, color: Colors.black),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(
      //                 'Address: ${odprovider.orderDetail.address}',
      //                 style: TextStyle(fontSize: 16, color: Colors.black),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(
      //                 'Phone: ${odprovider.orderDetail.phone}',
      //                 style: TextStyle(fontSize: 16, color: Colors.black),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               odprovider.orderDetail.status != -1
      //                   ? Text(
      //                       'Note: ${odprovider.orderDetail.note}',
      //                       style: TextStyle(fontSize: 16, color: Colors.black),
      //                     )
      //                   : Text(
      //                       'Reason: ${odprovider.orderDetail.reason}',
      //                       style: TextStyle(fontSize: 16, color: Colors.black),
      //                     ),
      //               const SizedBox(
      //                 height: 30,
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).size.height * 1 / 3,
      //                 width: MediaQuery.of(context).size.width * 4 / 5,
      //                 child: ResponsiveDatatable(
      //                   title: Text('Danh sách sản phẩm'),
      //                   reponseScreenSizes: [ScreenSize.xs],
      //                   headers: _headers,
      //                   source: odprovider.orderDetailTableSource,
      //                   selecteds: _selecteds,
      //                   showSelect: false,
      //                   autoHeight: false,
      //                   expanded: _expanded,
      //                   sortAscending: _sortAscending,
      //                   isLoading: _isLoading,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Text(
      //                   "Amount: ${odprovider.orderDetail.amount} VND",
      //                   style: TextStyle(fontSize: 16, color: Colors.black)),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               if (odprovider.orderDetail.status != -1)
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     ElevatedButton(
      //                       onPressed: () {
      //                         odprovider.downloadInvoice(
      //                             odprovider.orderDetail.orderId,
      //                             context);
      //                       },
      //                       child: Text('Xuất hóa đơn'),
      //                     ),
      //                       if(odprovider.orderDetail.status! < 2)
      //                       Row(
      //                         children: [
      //                           if(odprovider.orderDetail.status != 1)
      //                           ElevatedButton(
      //                             onPressed: () {
      //                               odprovider.updateOrderStatus(
      //                                   odprovider.orderDetail.orderId!,
      //                                   1,
      //                                   '',
      //                                   context);
      //                             },
      //                             child: Text('Giao hàng'),
      //                             style: ElevatedButton.styleFrom(
      //                                 primary: Colors.green),
      //                           ),
      //                           SizedBox(
      //                             width: 20,
      //                           ),
      //                           ElevatedButton(
      //                             onPressed: () {
      //                               odprovider.updateOrderStatus(
      //                                   odprovider.orderDetail.orderId!,
      //                                   -1,
      //                                   '',
      //                                   context);
      //                             },
      //                             child: Text('Hủy đơn hàng'),
      //                             style: ElevatedButton.styleFrom(
      //                                 primary: Colors.red),
      //                           ),
      //                         ],
      //                       )
      //                   ],
      //                 )
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

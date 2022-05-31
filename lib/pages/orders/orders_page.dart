import 'dart:math';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  
  TablesProvider? _tablesProvider;
  
  late List<DatatableHeader> _headers;

  List<int> _perPages = [5, 10, 15, 20];
  int _total = 100;
  int? _currentPerPage = 5;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;
  var random = new Random();

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    print(i);
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "id": i,
        "userId": "$i\000$i",
        "total": "Product $i",
        "createdAt": "Category-$i",
        "note": i * 10.00,
        "reason": "20.00",
        "status": "${i}0.20",
      });
      i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_tablesProvider!.ordersTableSource);
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start: 0}) async {
    setState(() => _isLoading = true);
    var _expandedLen =
    _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(Duration(seconds: 0)).then((value) {
      _expanded = List.generate(_expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) => data[_searchKey!]
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(_rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    /// set headers
    _headers = [
      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "User Id",
          value: "userId",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Total",
          value: "total",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Created At",
          value: "createdAt",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Note",
          value: "note",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Reason",
          value: "reason",
          flex: 2,
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Status",
          value: "status",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
    ];
    Future.delayed(Duration.zero, () {
      _tablesProvider = Provider.of<TablesProvider>(context, listen: false);
      _initializeData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RESPONSIVE DATA TABLE"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text("home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("data"),
              onTap: () {},
            )
          ],
        ),
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
                        onPressed: () => {},
                        icon: Icon(Icons.add),
                        label: Text("new item"),
                      ),
                      reponseScreenSizes: [ScreenSize.xs],
                      actions: [
                        if (_isSearch)
                          Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter search term based on ' +
                                        _searchKey!
                                            .replaceAll(new RegExp('[\\W_]+'), ' ')
                                            .toUpperCase(),
                                    prefixIcon: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            _isSearch = false;
                                          });
                                          _initializeData();
                                        }),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search), onPressed: () {})),
                                onSubmitted: (value) {
                                  _filterData(value);
                                },
                              )),
                        if (!_isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  _isSearch = true;
                                });
                              })
                      ],
                      headers: _headers,
                      source: _source,
                      selecteds: _selecteds,
                      showSelect: _showSelect,
                      autoHeight: false,
                      dropContainer: (data) {
                        if (int.tryParse(data['id'].toString())!.isEven) {
                          return Text("is Even");
                        }
                        return _DropDownContainer(data: data);
                      },
                      onChangedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onSubmittedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onTabRow: (data) {
                        print(data);
                      },
                      onSort: (value) {
                        setState(() => _isLoading = true);

                        setState(() {
                          _sortColumn = value;
                          _sortAscending = !_sortAscending;
                          if (_sortAscending) {
                            _sourceFiltered.sort((a, b) =>
                                b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                          } else {
                            _sourceFiltered.sort((a, b) =>
                                a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                          }
                          var _rangeTop = _currentPerPage! < _sourceFiltered.length
                              ? _currentPerPage!
                              : _sourceFiltered.length;
                          _source = _sourceFiltered.getRange(0, _rangeTop).toList();
                          _searchKey = value;

                          _isLoading = false;
                        });
                      },
                      expanded: _expanded,
                      sortAscending: _sortAscending,
                      sortColumn: _sortColumn,
                      isLoading: _isLoading,
                      onSelect: (value, item) {
                        print("$value  $item ");
                        if (value!) {
                          setState(() => _selecteds.add(item));
                        } else {
                          setState(
                                  () => _selecteds.removeAt(_selecteds.indexOf(item)));
                        }
                      },
                      onSelectAll: (value) {
                        if (value!) {
                          setState(() => _selecteds =
                              _source.map((entry) => entry).toList().cast());
                        } else {
                          setState(() => _selecteds.clear());
                        }
                      },
                      footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (_perPages.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton<int>(
                              value: _currentPerPage,
                              items: _perPages
                                  .map((e) => DropdownMenuItem<int>(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  _currentPerPage = value;
                                  _currentPage = 1;
                                  _resetData();
                                });
                              },
                              isExpanded: false,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: _currentPage == 1
                              ? null
                              : () {
                            var _nextSet = _currentPage - _currentPerPage!;
                            setState(() {
                              _currentPage = _nextSet > 1 ? _nextSet : 1;
                              _resetData(start: _currentPage - 1);
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: _currentPage + _currentPerPage! - 1 > _total
                              ? null
                              : () {
                            var _nextSet = _currentPage + _currentPerPage!;

                            setState(() {
                              _currentPage = _nextSet < _total
                                  ? _nextSet
                                  : _total - _currentPerPage!;
                              _resetData(start: _nextSet - 1);
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _initializeData,
        child: Icon(Icons.refresh_sharp),
      ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),

        /// ],
        children: _children,
      ),
    );
  }
  // List<Map<String, dynamic>> _source = [];
  // late List<DatatableHeader> _headers;
  // int? _currentPerPage = 10;
  // List<bool>? _expanded;
  // bool _isLoading = true;
  //
  // List<Map<String, dynamic>> _generateData({int n: 100}) {
  //   final List source = List.filled(n, Random.secure());
  //   List<Map<String, dynamic>> temps = [];
  //   var i = _source.length;
  //   print(i);
  //   for (var data in source) {
  //     temps.add({
  //       "id": i,
  //       "sku": "$i\000$i",
  //       "name": "Product $i",
  //       "category": "Category-$i",
  //       "price": i * 10.00,
  //       "margin": "${i}0.20",
  //       "in_stock": "${i}0",
  //       "alert": "5"
  //     });
  //     i++;
  //   }
  //   return temps;
  // }
  //
  // _initData() async {
  //   setState(() => _isLoading = true);
  //   Future.delayed(Duration(seconds: 2)).then((value) {
  //     _source.addAll(_generateData(n: 100));
  //     _expanded = List.generate(_currentPerPage!, (index) => false);
  //     setState(() => _isLoading = false);
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initData();
  //   _headers = [
  //     DatatableHeader(
  //         text: "ID",
  //         value: "id",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.center),
  //     DatatableHeader(
  //         text: "Name",
  //         value: "name",
  //         show: true,
  //         flex: 2,
  //         sortable: true,
  //         editable: true,
  //         textAlign: TextAlign.left),
  //     DatatableHeader(
  //         text: "SKU",
  //         value: "sku",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.center),
  //     DatatableHeader(
  //         text: "Category",
  //         value: "category",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.left),
  //     DatatableHeader(
  //         text: "Price",
  //         value: "price",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.left),
  //     DatatableHeader(
  //         text: "Margin",
  //         value: "margin",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.left),
  //     DatatableHeader(
  //         text: "In Stock",
  //         value: "in_stock",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.left),
  //     DatatableHeader(
  //         text: "Alert",
  //         value: "alert",
  //         show: true,
  //         sortable: true,
  //         textAlign: TextAlign.left)
  //   ];
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
  //   return SingleChildScrollView(
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //         PageHeader(
  //           text: 'Orders',
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           padding: EdgeInsets.all(0),
  //           constraints: BoxConstraints(
  //             maxHeight: 700,
  //           ),
  //           child: Card(
  //             elevation: 1,
  //             shadowColor: Colors.black,
  //             clipBehavior: Clip.none,
  //             child: ResponsiveDatatable(
  //               // actions: [
  //               //   if (tablesProvider.isSearch)
  //               //     Expanded(
  //               //         child: TextField(
  //               //       decoration: InputDecoration(
  //               //           prefixIcon: IconButton(
  //               //               icon: Icon(Icons.cancel),
  //               //               onPressed: () {
  //               //                 setState(() {
  //               //                   tablesProvider.isSearch = false;
  //               //                 });
  //               //               }),
  //               //           suffixIcon: IconButton(
  //               //               icon: Icon(Icons.search), onPressed: () {})),
  //               //     )),
  //               //   if (!tablesProvider.isSearch)
  //               //     IconButton(
  //               //         icon: Icon(Icons.search),
  //               //         onPressed: () {
  //               //           setState(() {
  //               //             tablesProvider.isSearch = true;
  //               //           });
  //               //         })
  //               // ],
  //               headers: _headers,
  //               source: _source,
  //               selecteds: tablesProvider.selecteds,
  //               showSelect: tablesProvider.showSelect,
  //               autoHeight: false,
  //               expanded: _expanded,
  //               // onTabRow: (data) {
  //               //   print(data);
  //               // },
  //               // onSort: tablesProvider.onSort,
  //               // sortAscending: tablesProvider.sortAscending,
  //               // sortColumn: tablesProvider.sortColumn,
  //               // isLoading: tablesProvider.isLoading,
  //               // onSelect: tablesProvider.onSelected,
  //               // onSelectAll: tablesProvider.onSelectAll,
  //               footers: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 15),
  //                   child: Text("Rows per page:"),
  //                 ),
  //                 if (tablesProvider.perPages != null)
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 15),
  //                     child: DropdownButton(
  //                         value: tablesProvider.currentPerPage,
  //                         items: tablesProvider.perPages
  //                             .map((e) => DropdownMenuItem(
  //                                   child: Text("$e"),
  //                                   value: e,
  //                                 ))
  //                             .toList(),
  //                         onChanged: (value) {}),
  //                   ),
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 15),
  //                   child: Text(
  //                       "${tablesProvider.currentPage} - ${tablesProvider.currentPage} of ${tablesProvider.total}"),
  //                 ),
  //                 IconButton(
  //                   icon: Icon(
  //                     Icons.arrow_back_ios,
  //                     size: 16,
  //                   ),
  //                   onPressed: tablesProvider.previous,
  //                   padding: EdgeInsets.symmetric(horizontal: 15),
  //                 ),
  //                 IconButton(
  //                   icon: Icon(Icons.arrow_forward_ios, size: 16),
  //                   onPressed: tablesProvider.next,
  //                   padding: EdgeInsets.symmetric(horizontal: 15),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ]));
  // }
}

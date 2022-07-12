import 'package:ecommerce_admin_tut/provider/statictic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';

class StatisticDetail extends StatefulWidget {
  const StatisticDetail({Key? key}) : super(key: key);

  @override
  State<StatisticDetail> createState() => _StatisticDetailState();
}

class _StatisticDetailState extends State<StatisticDetail> {
  StatictisProvider? _statictisProvider;

  late List<DatatableHeader> _headers;

  List<bool>? _expanded;
  String? _searchKey = "id";

  // int _currentPage = 1;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];

  // ignore: unused_field
  String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = false;

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_statictisProvider!.revenueTableSource.length, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_statictisProvider!.revenueTableSource);
      _sourceFiltered = _sourceOriginal;
      _source = _sourceFiltered.getRange(0, _statictisProvider!.currentPerPage).toList();
      setState(() => _isLoading = false);
    });
  }

  // _resetData({start: 0}) async {
  //   setState(() => _isLoading = true);
  //   var _expandedLen =
  //       _total - start < _currentPerPage! ? _total - start : _currentPerPage;
  //   Future.delayed(Duration(seconds: 0)).then((value) {
  //     _expanded = List.generate(_expandedLen as int, (index) => false);
  //     _source.clear();
  //     _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
  //     setState(() => _isLoading = false);
  //   });
  // }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "STT",
          value: "stt",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Date",
          value: "date",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Amounts",
          value: "amounts",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Tax",
          value: "tax",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Total Originals",
          value: "total_originals",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Revenue",
          value: "revenue",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
    ];
    Future.delayed(Duration.zero, () {
      _statictisProvider = Provider.of<StatictisProvider>(context, listen: false);
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
                  title: Text(
                    'Revenue Statistic',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  reponseScreenSizes: [ScreenSize.xs],
                  headers: _headers,
                  source: _source,
                  selecteds: _selecteds,
                  showSelect: _showSelect,
                  autoHeight: false,
                  onChangedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onSubmittedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onTabRow: (data) {
                    print(data['id']);
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
                      var _rangeTop = _statictisProvider!.currentPerPage < _sourceFiltered.length
                          ? _statictisProvider!.currentPerPage
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
                  // onSelect: (value, item) {
                  //   print("$value  $item ");
                  //   if (value!) {
                  //     setState(() => _selecteds.add(item));
                  //   } else {
                  //     setState(
                  //         () => _selecteds.removeAt(_selecteds.indexOf(item)));
                  //   }
                  // },
                  // onSelectAll: (value) {
                  //   if (value!) {
                  //     setState(() => _selecteds =
                  //         _source.map((entry) => entry).toList().cast());
                  //   } else {
                  //     setState(() => _selecteds.clear());
                  //   }
                  // },
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
                  //                   child: Text("$e"),
                  //                   value: e,
                  //                 ))
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
                  //         Text("$_currentPage - $_currentPerPage of $_total"),
                  //   ),
                  //   IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back_ios,
                  //       size: 16,
                  //     ),
                  //     onPressed: _currentPage == 1
                  //         ? null
                  //         : () {
                  //             var _nextSet = _currentPage - _currentPerPage!;
                  //             setState(() {
                  //               _currentPage = _nextSet > 1 ? _nextSet : 1;
                  //               _resetData(start: _currentPage - 1);
                  //             });
                  //           },
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //   ),
                  //   IconButton(
                  //     icon: Icon(Icons.arrow_forward_ios, size: 16),
                  //     onPressed: _currentPage + _currentPerPage! - 1 >= _total
                  //         ? null
                  //         : () {
                  //             var _nextSet = _currentPage + _currentPerPage!;
                  //
                  //             setState(() {
                  //               _currentPage = _nextSet < _total
                  //                   ? _nextSet
                  //                   : _total - _currentPerPage!;
                  //               _resetData(start: _nextSet - 1);
                  //             });
                  //           },
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //   )
                  // ],
                ),
              ),
            ),
          ],),),
      floatingActionButton: FloatingActionButton(
        onPressed: _initializeData,
        child: Icon(Icons.refresh_sharp),
      ),
    );
  }
}

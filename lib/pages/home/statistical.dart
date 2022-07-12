import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/pages/home/statistic_detail.dart';
import 'package:ecommerce_admin_tut/provider/statictic_provider.dart';
import 'package:ecommerce_admin_tut/widgets/charts/revenue_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/tab_bar_custom.dart';

class Statistical extends StatefulWidget {
  const Statistical({Key? key}) : super(key: key);

  @override
  State<Statistical> createState() => _StatisticalState();
}

class _StatisticalState extends State<Statistical>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  List<String> items = ["Revenue statistics", "Order statistics"];
  String? selectedItem = "Revenue statistics";

  String date = "";
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  String startTime = '--/--/----';
  String endTime = '--/--/----';

  @override
  Widget build(BuildContext context) {
    final StatictisProvider statictisProvider =
        Provider.of<StatictisProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Loại thống kê: ',
              style: TextStyle(fontSize: 16, height: 20 / 16),
            ),
            DropdownButton(
              value: selectedItem,
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (item) =>
                  setState(() => selectedItem = item as String?),
            ),
            const SizedBox(
              width: 40,
            ),
            const Text(
              'Thời gian: ',
              style: TextStyle(fontSize: 16, height: 20 / 16),
            ),
            InkWell(
                onTap: () {
                  _selectDate(context, true);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(startTime),
                )),
            const Text(
              ' - ',
              style: TextStyle(fontSize: 16, height: 20 / 16),
            ),
            InkWell(
              onTap: () {
                _selectDate(context, false);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(endTime),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Timestamp ts1 = Timestamp.fromDate(selectedDate);
                Timestamp ts2 = Timestamp.fromDate(selectedDate2);
                log('${ts1.seconds}');
                log('${ts2.seconds}');
                statictisProvider.getRevenue(ts1.seconds, ts2.seconds);
                log('${statictisProvider.revenues}');
              },
              child: Text('Thống Kê'),
            ),
          ],
        ),
        TabBarCustom(
          controller: _tabController,
          tabs: ['Biểu Đồ', 'Chi Tiết Thống Kê'],
          isScrollable: false,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              statictisProvider.statistics.isEmpty == true
                  ? Container()
                  : LineChartSample1(),
              statictisProvider.statistics.isEmpty == true
                  ? Container()
                  : StatisticDetail(),
            ],
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context, bool b) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: b ? selectedDate : selectedDate2,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        if (b) {
          selectedDate = selected;
          startTime =
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        } else {
          selectedDate2 = selected;
          endTime =
              "${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}";
        }
      });
  }
}

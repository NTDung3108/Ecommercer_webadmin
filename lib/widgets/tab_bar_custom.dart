import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  final Color? color;
  final bool isScrollable;
  final Function(int)? onTap;

  const TabBarCustom({
    Key? key,
    required this.controller,
    required this.tabs,
    this.color,
    this.isScrollable = true,
    this.onTap,
  }) : super(key: key);

  // Height property for use in AppbarCustom bottom
  double get height => 44;

  double get indicatorHeight => 2;

  @override
  Widget build(BuildContext context) {
    Color color = this.color ?? Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F6FF), width: 1)),
      ),
      child: TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: indicatorHeight,
            color: color,
          ),
        ),
        onTap: onTap,
        labelColor: color,
        labelStyle: TextStyle(fontSize: 14, height: 20/14, fontWeight: FontWeight.bold),
        unselectedLabelColor: Color(0xFF8E9ABB),
        unselectedLabelStyle: TextStyle(fontSize: 14, height: 20/14),
        labelPadding: EdgeInsets.symmetric(horizontal: 16),
        isScrollable: isScrollable,
        controller: controller,
        tabs: tabs
            .map((label) => Tab(
          text: '$label',
          height: height - indicatorHeight,
        ))
            .toList(),
      ),
    );
  }
}

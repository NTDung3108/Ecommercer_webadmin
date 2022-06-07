import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:ecommerce_admin_tut/widgets/tab_bar_custom.dart';
import 'package:ecommerce_admin_tut/widgets/top_buyer.dart';
import 'package:flutter/material.dart';

class TopRank extends StatefulWidget {
  const TopRank({Key? key}) : super(key: key);

  @override
  State<TopRank> createState() => _TopRankState();
}

class _TopRankState extends State<TopRank> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBarCustom(
          controller: _tabController,
          tabs: ["Top Buyers", "Top Products"],
          // isScrollable: false,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  CustomText(
                    text: 'Top Buyers',
                    size: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return TopBuyerWidget();
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text: 'Top Buyers',
                    size: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return TopBuyerWidget();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:ecommerce_admin_tut/pages/home/top_rank.dart';
import 'package:ecommerce_admin_tut/provider/home_provider.dart';
import 'package:ecommerce_admin_tut/widgets/cards/cards_list.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'statistical.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> with TickerProviderStateMixin{
  HomeProvider? _homeProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _homeProvider = Provider.of<HomeProvider>(context, listen: false);
      _homeProvider!.init();
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(text: "Bảng Diều Khiển",),
        CardsList(),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 600,
                  width: MediaQuery.of(context).size.width / 1.9,
                child: Statistical(),
              ),//SalesChart()),
              Container(
                width:  MediaQuery.of(context).size.width / 4,
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300]!,
                          offset: Offset(0, 3),
                          blurRadius: 16
                      )
                    ]),
                child: TopRank()
              )
            ],
          ),
        ),
      ],
    );
  }
}
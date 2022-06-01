import 'package:flutter/material.dart';

import '../../widgets/base_appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Type: ',
              style: TextStyle(fontSize: 16, height: 20 / 16),
            ),
            const SizedBox(width: 40,),
            const Text(
              'Time: ',
              style: TextStyle(fontSize: 16, height: 20 / 16),
            ),
          ],
        ),
        TabBarCustom(
          controller: _tabController,
          tabs: ['Diagram', 'Detail Statistical'],
          isScrollable: false,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [Container(), Container()],
          ),
        ),
      ],
    );
  }
}

import 'package:ecommerce_admin_tut/provider/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'navbar_mobile.dart';
import 'navbar_tablet_desktop.dart';

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldState;

  const CustomNavigationBar({Key? key, this.scaffoldState}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(
        // scaffoldState: scaffoldState!,
      ),
      tablet: NavigationTabletDesktop(),
    );
  }
}

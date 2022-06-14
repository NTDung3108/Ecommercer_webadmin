import 'package:ecommerce_admin_tut/helpers/app_colors.dart';
import 'package:ecommerce_admin_tut/provider/staff_provider.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StaffProvider>(
      create: (context) => StaffProvider.init(),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[200]!, offset: Offset(3, 5), blurRadius: 17)
        ]),
        height: 50,
        child: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
                Stack(
                  children: [
                    FlatButton.icon(
                      icon: Icon(Icons.notifications),
                      label: CustomText(
                        text: 'Notifications',
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      top: 4,
                      left: 9,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.settings),
                  label: CustomText(
                    text: 'Settings',
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<StaffProvider>(
                      builder: (context, staff, child) {
                        return CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage('images/profile.jpg'),
                        );
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Consumer<StaffProvider>(
                      builder: (context, staff, child) {
                        if(staff.info != null)
                        return CustomText(
                            text: '${staff.info!.firstName} ${staff.info!.lastName}',
                          );
                        else
                          return Container();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        print("CLICKED");
                        myPopMenu();
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        onSelected: (value) {},
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.print),
                      ),
                      Text('Print')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.share),
                      ),
                      Text('Share')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.add_circle),
                      ),
                      Text('Add')
                    ],
                  )),
            ]);
  }
}

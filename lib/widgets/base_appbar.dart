import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseAppbar extends AppBar with PreferredSizeWidget {
  BaseAppbar({required BuildContext context, String? title})
      : super(
    title: Text(
      title ?? "",
      style: TextStyle(fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color(0xFF212633),
      ),
    ),
    backgroundColor: Colors.transparent,
    iconTheme: Theme.of(context).iconTheme.copyWith(
      color: Color(0xFF212633),
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  @override
  get preferredSize => Size.fromHeight(44.0);
}
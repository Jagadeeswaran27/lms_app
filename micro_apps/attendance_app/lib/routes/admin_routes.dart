import 'package:attendance_app/screens/admin/item_detail_screen.dart';
import 'package:attendance_app/screens/admin/items_list_screen.dart';
import 'package:flutter/material.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String itemList = "item-list";
  static const String itemDetail = "item-detail";

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      itemList: (context) => const ItemsListScreen(),
      itemDetail: (context) => const ItemDetailScreen(),
    };
  }

  static String get initialRoute {
    return AdminRoutes.itemList;
  }
}

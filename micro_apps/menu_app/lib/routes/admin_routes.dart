import 'package:flutter/material.dart';

import 'package:menu_app/screens/admin/add_item_screen.dart';
import 'package:menu_app/screens/admin/item_list_screen.dart';

class AdminRoutes {
  AdminRoutes._();

  static const String itemList = '/item-list';
  static const String addItem = '/add-item';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      itemList: (context) => const ItemListScreen(),
      addItem: (context) => const AddItemScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.itemList;
  }
}

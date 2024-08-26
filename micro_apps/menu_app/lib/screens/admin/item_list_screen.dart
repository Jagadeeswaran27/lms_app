import 'package:flutter/material.dart';

import 'package:menu_app/containers/admin/item_list_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: Strings.itemList,
      showBackButton: false,
      child: ItemListContainer(),
    );
  }
}

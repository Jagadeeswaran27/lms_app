import 'package:flutter/material.dart';

import 'package:menu_app/containers/admin/add_item_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: Strings.item,
      child: AddItemContainer(),
    );
  }
}

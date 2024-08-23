import 'package:flutter/material.dart';

import 'package:registration_app/containers/student/student_item_list_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StudentItemListScreen extends StatelessWidget {
  const StudentItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      topBarText: Strings.itemList,
      icon: const SVGLoader(
        image: icons.Icons.cartIconSvg,
        width: 30,
        height: 30,
      ),
      child: const StudentItemListContainer(),
      onIconTap: () {
        Navigator.of(context).pushNamed(StudentRoutes.cart);
      },
    );
  }
}

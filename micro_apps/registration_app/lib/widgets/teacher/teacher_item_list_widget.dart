import 'package:flutter/material.dart';

import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/widgets/common/item_card.dart';

class TeacherItemListWidget extends StatelessWidget {
  const TeacherItemListWidget({super.key});

  void navigateToItemDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      TeacherRoutes.itemDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ItemCard(
          onPressed: () => navigateToItemDetail(context),
        ),
      ],
    );
  }
}

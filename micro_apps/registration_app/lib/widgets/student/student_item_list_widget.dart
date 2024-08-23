import 'package:flutter/material.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/common/item_card.dart';

class StudentItemListWidget extends StatelessWidget {
  const StudentItemListWidget({super.key});

  void navigateToItemDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      StudentRoutes.itemDetail,
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

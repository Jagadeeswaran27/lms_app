import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';

class EnquiryReceptionTitleCard extends StatelessWidget {
  const EnquiryReceptionTitleCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ThemeColors.cardBorderColor,
            width: 0.2,
          ),
          top: BorderSide(
            color: ThemeColors.cardBorderColor,
            width: 0.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
          )
        ],
        color: ThemeColors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            'Hello !! $name',
            style: Theme.of(context).textTheme.bodyMediumTitleBrown,
          ),
        ],
      ),
    );
  }
}

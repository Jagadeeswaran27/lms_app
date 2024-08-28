import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class EnquiryCard extends StatelessWidget {
  const EnquiryCard({
    super.key,
    required this.ticketNo,
    required this.subject,
    required this.onTap,
    this.imageUrl,
  });

  final String ticketNo;
  final String subject;
  final void Function() onTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: ThemeColors.cardColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                imageUrl ?? Strings.url,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "XXXXXX",
                  style:
                      Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
                ),
                Text(
                  "Student",
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      Strings.ticketNo,
                      style: Theme.of(context).textTheme.titleSmallTitleBrown,
                    ),
                    Text(
                      ticketNo,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmallPrimarySemiBold,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

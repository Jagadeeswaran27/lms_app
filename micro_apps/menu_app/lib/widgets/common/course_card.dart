import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: ThemeColors.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                      left: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                      bottom: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'XXXXXX',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumTitleBrownSemiBold,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        style: Theme.of(context).textTheme.displaySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

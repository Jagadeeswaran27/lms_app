import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';

class CourseDetailWidget extends StatelessWidget {
  const CourseDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ThemeColors.cardColor,
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          )
        ],
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      'https://via.placeholder.com/100',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.english,
                        style: Theme.of(context).textTheme.bodyLargeTitleBrown,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            Strings.courseCode,
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumTitleBrownSemiBold,
                          ),
                          Text(
                            '3245',
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumPrimarySemiBold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            Strings.duration,
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumTitleBrownSemiBold,
                          ),
                          Text(
                            '64 Hours',
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumPrimarySemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

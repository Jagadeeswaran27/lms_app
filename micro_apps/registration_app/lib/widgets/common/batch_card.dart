import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/drop_down_row.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({
    super.key,
    required this.batchDay,
    required this.batchTime,
    required this.onBatchDayChanged,
    required this.onBatchTimeChanged,
  });

  final String batchDay;
  final String batchTime;
  final void Function(String? newValue) onBatchDayChanged;
  final void Function(String? newValue) onBatchTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: ThemeColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 140.0,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ThemeColors.cardBorderColor,
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropDownRow(
                      label: Strings.days,
                      value: batchDay,
                      options: const ["Weekend", "Weekday"],
                      onChanged: onBatchDayChanged,
                    ),
                    const SizedBox(height: 20),
                    DropDownRow(
                      label: Strings.time,
                      value: batchTime,
                      options: const ["Morning", "Evening"],
                      onChanged: onBatchTimeChanged,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

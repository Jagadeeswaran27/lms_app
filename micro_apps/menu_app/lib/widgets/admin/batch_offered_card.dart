import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class BatchOfferedCard extends StatefulWidget {
  final List<String> selectedDays;
  final List<String> selectedTime;
  final ValueChanged<List<String>> onSelectedDaysChanged;
  final ValueChanged<List<String>> onSelectedTimeChanged;

  const BatchOfferedCard({
    super.key,
    required this.selectedDays,
    required this.selectedTime,
    required this.onSelectedDaysChanged,
    required this.onSelectedTimeChanged,
  });

  @override
  BatchOfferedCardState createState() => BatchOfferedCardState();
}

class BatchOfferedCardState extends State<BatchOfferedCard> {
  void _handleDayChange(String day, bool isSelected) {
    final newSelectedDays = List<String>.from(widget.selectedDays);
    if (isSelected) {
      newSelectedDays.add(day);
    } else {
      newSelectedDays.remove(day);
    }
    widget.onSelectedDaysChanged(newSelectedDays);
  }

  void _handleTimeChange(String time, bool isSelected) {
    final newSelectedTime = List<String>.from(widget.selectedTime);
    if (isSelected) {
      newSelectedTime.add(time);
    } else {
      newSelectedTime.remove(time);
    }
    widget.onSelectedTimeChanged(newSelectedTime);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedTime);
    return Container(
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
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.days,
            style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CustomCheckbox(
                text: 'Weekend',
                value: widget.selectedDays.contains('Weekend'),
                onChanged: (bool? newValue) {
                  _handleDayChange('Weekend', newValue!);
                },
              ),
              const SizedBox(width: 20),
              _CustomCheckbox(
                text: 'Weekday',
                value: widget.selectedDays.contains('Weekday'),
                onChanged: (bool? newValue) {
                  _handleDayChange('Weekday', newValue!);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            Strings.time,
            style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CustomCheckbox(
                text: 'Morning',
                value: widget.selectedTime.contains('Morning'),
                onChanged: (bool? newValue) {
                  _handleTimeChange('Morning', newValue!);
                },
              ),
              const SizedBox(width: 20),
              _CustomCheckbox(
                text: 'Evening',
                value: widget.selectedTime.contains('Evening'),
                onChanged: (bool? newValue) {
                  _handleTimeChange('Evening', newValue!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CustomCheckbox({
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ThemeColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2.5),
            blurRadius: 9,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: ThemeColors.titleBrown,
          ),
        ],
      ),
    );
  }
}

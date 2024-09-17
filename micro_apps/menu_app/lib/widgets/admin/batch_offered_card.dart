import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';

class BatchOfferedCard extends StatefulWidget {
  final List<String> selectedDays;
  final List<String> selectedTime;
  final ValueChanged<List<String>> onSelectedDaysChanged;
  final ValueChanged<List<String>> onSelectedTimeChanged;
  final void Function(List<String>) onSaveCustomDays;
  final void Function(String) onSaveCustomTime;

  const BatchOfferedCard({
    super.key,
    required this.selectedDays,
    required this.selectedTime,
    required this.onSaveCustomTime,
    required this.onSaveCustomDays,
    required this.onSelectedDaysChanged,
    required this.onSelectedTimeChanged,
  });

  @override
  BatchOfferedCardState createState() => BatchOfferedCardState();
}

class BatchOfferedCardState extends State<BatchOfferedCard> {
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> customDays = [];
  String? customTime;
  String? customDaysErr;

  void _showCustomDayPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Days'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day),
                        value: customDays.contains(day),
                        onChanged: (bool? isChecked) {
                          setState(() {
                            if (isChecked == true) {
                              customDays.add(day);
                            } else {
                              customDays.remove(day);
                            }
                          });
                        },
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.selectedDays.remove("Custom");
                });
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (customDays.isEmpty) {
                  showSnackbar(context, "At least select one day");
                  return;
                }
                widget.onSaveCustomDays(customDays);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCustomTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      customTime = pickedTime.format(context);
      widget.onSaveCustomTime(customTime!);
    } else {
      setState(() {
        widget.selectedTime.remove("Custom");
      });
    }
  }

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
          Wrap(
            runSpacing: 20,
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
              const SizedBox(width: 20),
              _CustomCheckbox(
                text: 'Custom',
                value: widget.selectedDays.contains('Custom'),
                onChanged: (bool? newValue) {
                  _handleDayChange('Custom', newValue!);
                  if (newValue) {
                    _showCustomDayPickerDialog(context);
                  }
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
          Wrap(
            runSpacing: 20,
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
              const SizedBox(width: 20),
              _CustomCheckbox(
                text: 'Custom',
                value: widget.selectedTime.contains('Custom'),
                onChanged: (bool? newValue) {
                  _handleTimeChange('Custom', newValue!);
                  if (newValue) {
                    _showCustomTimePicker();
                  }
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

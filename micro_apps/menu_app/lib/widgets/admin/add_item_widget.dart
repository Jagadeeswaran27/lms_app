import 'dart:io';

import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/admin/add_title_card.dart';
import 'package:menu_app/widgets/admin/batch_offered_card.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/generic_media_dialog.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({
    super.key,
    required this.isLoading,
    required this.addItem,
    required this.subCategory,
  });

  final bool isLoading;
  final Function(Map<String, dynamic>, File) addItem;
  final String subCategory;

  @override
  AddItemWidgetState createState() => AddItemWidgetState();
}

class AddItemWidgetState extends State<AddItemWidget> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  File? _image;
  bool _isUploadValid = true;
  bool _isBatchOfferedSelected = false;
  String? _isBatchOfferedError;
  String? _titleError;
  String _itemTitle = '';
  String _shortDescription = '';
  String _aboutDescription = '';
  List<String> _selectedDays = [];
  String _batchTime = 'Morning';
  String _amountDetails = '';
  String _totalHours = '';

  void _handleBatchOfferedDaysChange(List<String> days) {
    setState(() {
      _selectedDays = days;
    });
  }

  void _handleTitleChange(String value) {
    setState(() {
      titleController.text = value;
      _itemTitle = value;
      _titleError = null;
    });
  }

  void onSaveMedia(File file) {
    setState(() {
      _image = file;
      _isUploadValid = true;
    });
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _image = null;
    setState(() {
      _isUploadValid = true;
      _itemTitle = '';
      _shortDescription = '';
      _aboutDescription = '';
      _selectedDays = [];
      _batchTime = 'morning';
      _amountDetails = '';
      _totalHours = '';
      _isBatchOfferedSelected = false;
      _isBatchOfferedError = null;
      _titleError = null;
      titleController.text = '';
      titleController.clear();
    });
  }

  void _onAddItem() {
    bool isFormValid = _formKey.currentState!.validate();
    if (_image == null) {
      setState(() {
        _isUploadValid = _image == null ? false : true;
      });
      showSnackbar(context, 'Please upload an image');
      return;
    }

    if (_itemTitle == '') {
      setState(() {
        _titleError = "Invalid title";
      });
      return;
    }

    if (widget.subCategory == 'courses' && _isBatchOfferedSelected == false) {
      setState(() {
        _isBatchOfferedError = "Invalid batch offered";
      });
      return;
    }

    if (isFormValid) {
      _formKey.currentState!.save();
      Map<String, dynamic> formData = {
        'itemTitle': _itemTitle,
        'shortDescription': _shortDescription,
        'aboutDescription': _aboutDescription,
        'batchDay': widget.subCategory == 'courses' ? _selectedDays : null,
        'batchTime': widget.subCategory == 'courses' ? _batchTime : null,
        'amount': _amountDetails,
        'totalHours': _totalHours,
      };
      widget.addItem({...formData}, _image!);
      resetForm();
    }
  }

  void _onProfileUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericMediaDialog(
          mediaHeading: Strings.addImage,
          onSaveMedia: onSaveMedia,
        );
      },
    );
  }

  void _handleBatchOfferedChange(bool? value) {
    setState(() {
      _isBatchOfferedSelected = value!;
      _isBatchOfferedError = null;
    });
  }

  void _handleBatchOfferedTimeChange(String? value) {
    setState(() {
      _batchTime = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AddTitleCard(
                image: _image,
                text: titleController.text,
                titleError: _titleError,
                onTitleChange: _handleTitleChange,
                onTap: _onProfileUpload,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.shortDescription,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                text: _shortDescription,
                onSaved: (value) => {_shortDescription = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidShortDescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.aboutDescription,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                text: _aboutDescription,
                onSaved: (value) => {_aboutDescription = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidAboutDescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (widget.subCategory == 'courses')
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isBatchOfferedSelected,
                          onChanged: _handleBatchOfferedChange,
                          activeColor: ThemeColors.titleBrown,
                        ),
                        Text(
                          Strings.addBatchOffered,
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                      ],
                    ),
                    if (_isBatchOfferedError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _isBatchOfferedError!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ThemeColors.primary),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (_isBatchOfferedSelected)
                      Column(
                        children: [
                          BatchOfferedCard(
                            selectedDays: _selectedDays,
                            selectedTime: _batchTime,
                            onSelectedDaysChanged:
                                _handleBatchOfferedDaysChange,
                            onSelectedTimeChanged:
                                _handleBatchOfferedTimeChange,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Total Hours (Number)",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormInput(
                      keyboardType: TextInputType.number,
                      text: _totalHours,
                      onSaved: (value) => {_totalHours = value!},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Row(
                children: [
                  Text(
                    Strings.amountDetails,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                keyboardType: TextInputType.number,
                text: _amountDetails,
                onSaved: (value) => {_amountDetails = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidAmountDetails;
                  }
                  return null;
                },
                onChanged: (value) {
                  _amountDetails = value;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.addItem,
                  onPressed: _onAddItem,
                  color: ThemeColors.primary,
                  buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                  svgIcon: icons.Icons.bookIcon,
                  isLoading: widget.isLoading,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

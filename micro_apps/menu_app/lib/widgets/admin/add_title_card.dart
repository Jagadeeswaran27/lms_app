import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/svg_lodder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddTitleCard extends StatefulWidget {
  final Function() onTap;
  final String text;
  final File? image;
  final String? titleError;
  final String? suggestionImage;
  final Function(String, String?) onTitleChange;
  final Function(String) onAddSuggestion;

  const AddTitleCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    this.suggestionImage,
    required this.onTitleChange,
    required this.titleError,
    required this.onAddSuggestion,
  });

  @override
  State<AddTitleCard> createState() => _AddTitleCardState();
}

class _AddTitleCardState extends State<AddTitleCard> {
  int _selectedFieldType = 0;
  final TextEditingController _typeAheadController = TextEditingController();

  void _handleAutoChange(int value) {
    setState(() {
      widget.onTitleChange('', null);
      _selectedFieldType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: widget.image != null
                    ? ClipOval(
                        child: Image.file(
                          widget.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : widget.suggestionImage != null
                        ? ClipOval(
                            child: Image.network(
                              widget.suggestionImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SVGLoader(image: icons.Icons.profileBackup),
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.addTitle,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: screenSize.width * 0.60,
                  child: FormInput(
                    text: '',
                    hintText: widget.text,
                    // initialValue: text,
                    onChanged: (value) => widget.onTitleChange(value, null),
                    fillColor: ThemeColors.white,
                    borderColor: ThemeColors.cardBorderColor,
                    borderWidth: 0.4,
                    hasShadow: true,
                    readOnly: true,
                  ),
                ),
                if (widget.titleError != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      widget.titleError!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ThemeColors.primary),
                    ),
                  ),
                const SizedBox(height: 18.0),
                Text(
                  Strings.inputType,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                ),
                Transform.translate(
                  offset: const Offset(-10, 0),
                  child: Column(
                    children: [
                      RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _selectedFieldType == 0,
                        groupValue: true,
                        onChanged: (value) => _handleAutoChange(0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        title: Text(
                          Strings.manual,
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -20),
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: _selectedFieldType == 1,
                          groupValue: true,
                          onChanged: (value) => _handleAutoChange(1),
                          title: Text(
                            Strings.auto,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumTitleBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Text(
                    '${_selectedFieldType == 0 ? Strings.manual : Strings.auto} Field',
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ),
                _selectedFieldType == 0
                    ? SizedBox(
                        width: screenSize.width * 0.60,
                        child: FormInput(
                          text: '',
                          hintText: widget.text,
                          // initialValue: text,
                          onChanged: (value) =>
                              widget.onTitleChange(value, null),
                          fillColor: ThemeColors.white,
                          borderColor: ThemeColors.cardBorderColor,
                          borderWidth: 0.4,
                          hasShadow: true,
                        ),
                      )
                    : TypeAheadField<QueryDocumentSnapshot>(
                        controller: _typeAheadController,
                        builder: (context, controller, focusNode) {
                          return FormInput(
                            text: '',
                            focusNode: focusNode,
                            controller: controller,
                            hintText: '',
                            borderColor: ThemeColors.cardBorderColor,
                            fillColor: ThemeColors.white,
                            borderWidth: 0.4,
                            hasShadow: true,
                          );
                        },
                        loadingBuilder: (context) =>
                            const CircularProgressIndicator(),
                        suggestionsCallback: (search) async {
                          if (search.isEmpty) {
                            return null;
                          }

                          try {
                            String capitalizedSearchTerm =
                                search[0].toUpperCase() +
                                    search.substring(1).toLowerCase();
                            final QuerySnapshot querySnapshot =
                                await FirebaseFirestore.instance
                                    .collection('suggestions')
                                    .where('name',
                                        isGreaterThanOrEqualTo:
                                            capitalizedSearchTerm)
                                    .where('name',
                                        isLessThan: '${capitalizedSearchTerm}z')
                                    .where('isApproved', isEqualTo: true)
                                    .get();
                            final listValues =
                                querySnapshot.docs.map((ele) => ele).toList();
                            return Future.value(listValues);
                          } catch (e) {
                            print('Error fetching suggestions: $e');
                            return [];
                          }
                        },
                        debounceDuration: const Duration(milliseconds: 500),
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: suggestion['image'] != null
                                  ? NetworkImage(suggestion['image'])
                                      as ImageProvider
                                  : null,
                            ),
                            title: Text(
                              suggestion['name'] as String,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        },
                        emptyBuilder: (context) => InkWell(
                          onTap: () {
                            widget.onAddSuggestion(_typeAheadController.text);
                            _typeAheadController.clear();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Add Suggestion',
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeColors.primary,
                              ),
                            ),
                          ),
                        ),
                        onSelected: (suggestion) {
                          widget.onTitleChange(
                              '${widget.text.isNotEmpty ? '${widget.text},' : ''}${suggestion['name']}',
                              suggestion['image']);
                          _typeAheadController.clear();
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/models/courses/search_model.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/special_form_input.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddTitleCard extends StatefulWidget {
  final Function() onTap;
  final String text;
  final SearchModel? image;
  final String? titleError;
  final bool showInputType;
  final int selectedFieldType;
  final bool isFieldEnabled;
  final Function(String) onTitleChange;
  final Function(String) onAddSuggestion;
  final Function(int) onAutoChange;
  final Function(bool) toggleShowInputType;
  final Function(QueryDocumentSnapshot) onSelectSuggestion;

  const AddTitleCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    required this.showInputType,
    required this.selectedFieldType,
    required this.isFieldEnabled,
    required this.onTitleChange,
    required this.titleError,
    required this.onAddSuggestion,
    required this.onAutoChange,
    required this.toggleShowInputType,
    required this.onSelectSuggestion,
  });

  @override
  State<AddTitleCard> createState() => _AddTitleCardState();
}

class _AddTitleCardState extends State<AddTitleCard> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextEditingController _typeAheadController = TextEditingController();

    void onFocusChange(bool hasFocus) {
      if (hasFocus && widget.text.isEmpty) {
        widget.toggleShowInputType(true);
      }
    }

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
                child: widget.image == null
                    ? const SVGLoader(image: icons.Icons.profileBackup)
                    : ClipOval(
                        child: widget.image!.url != null
                            ? Image.network(
                                widget.image!.url!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : widget.image!.file != null
                                ? Image.file(
                                    widget.image!.file!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : const SVGLoader(
                                    image: icons.Icons.profileBackup,
                                  ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                  child: SpecialFormInput(
                    text: widget.text,
                    hintText: widget.text,
                    onChanged: (value) => widget.onTitleChange(value),
                    fillColor: ThemeColors.white,
                    borderColor: ThemeColors.cardBorderColor,
                    borderWidth: 0.4,
                    hasShadow: true,
                    onFocusChange: onFocusChange,
                    readOnly: !widget.isFieldEnabled,
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
                Visibility(
                  visible: widget.showInputType,
                  child: Text(
                    Strings.inputType,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ),
                Visibility(
                    visible: widget.showInputType,
                    child: Transform.translate(
                      offset: const Offset(-10, 0),
                      child: Column(
                        children: [
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: widget.selectedFieldType == 0,
                            groupValue: true,
                            onChanged: (value) => widget.onAutoChange(0),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            title: Text(
                              'By Prompt',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumTitleBrown,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -20),
                            child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: widget.selectedFieldType == 1,
                              groupValue: true,
                              onChanged: (value) => widget.onAutoChange(1),
                              title: Text(
                                'All Available',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Visibility(
                    visible: widget.selectedFieldType >= 0,
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: Text(
                        '${widget.selectedFieldType == 0 ? Strings.manual : Strings.auto} Field',
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      ),
                    )),
                Visibility(
                  visible: widget.selectedFieldType >= 0,
                  child: TypeAheadField<QueryDocumentSnapshot>(
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
                      // Auto Field
                      if (widget.selectedFieldType == 1) {
                        try {
                          final QuerySnapshot querySnapshot =
                              await FirebaseFirestore.instance
                                  .collection('suggestions')
                                  .get();
                          final listValues =
                              querySnapshot.docs.map((ele) => ele).toList();
                          return Future.value(listValues);
                        } catch (e) {
                          print('Error fetching suggestions: $e');
                          return [];
                        }
                      }

                      // Manual Field
                      if (search.isEmpty) {
                        return null;
                      }

                      try {
                        final QuerySnapshot querySnapshot =
                            await FirebaseFirestore.instance
                                .collection('suggestions')
                                .where('name',
                                    isGreaterThanOrEqualTo:
                                        search.toLowerCase())
                                .where('name',
                                    isLessThan: '${search.toLowerCase()}z')
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
                    emptyBuilder: (context) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Text(
                        'No Suggestion Found',
                        style: TextStyle(
                          fontSize: 14,
                          color: ThemeColors.primary,
                        ),
                      ),
                    ),
                    onSelected: (suggestion) {
                      // widget.onTitleChange(
                      //   '${widget.text.isNotEmpty ? widget.text : ''}${suggestion['name']}',
                      // );
                      widget.onSelectSuggestion(suggestion);
                      _typeAheadController.clear();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

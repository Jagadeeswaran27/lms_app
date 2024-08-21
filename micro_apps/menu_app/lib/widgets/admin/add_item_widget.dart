import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/admin/add_title_card.dart';
import 'package:menu_app/widgets/admin/batch_offered_card.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({super.key});

  @override
  AddItemWidgetState createState() => AddItemWidgetState();
}

class AddItemWidgetState extends State<AddItemWidget> {
  bool _isBatchOfferedSelected = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Form(
          child: Column(
            children: [
              const AddTitleCard(),
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
              const FormInput(text: ""),
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
              const FormInput(text: ""),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isBatchOfferedSelected,
                    onChanged: (value) {
                      setState(() {
                        _isBatchOfferedSelected = value ?? false;
                      });
                    },
                    activeColor: ThemeColors.titleBrown,
                  ),
                  Text(
                    Strings.addBatchOffered,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_isBatchOfferedSelected)
                const Column(
                  children: [
                    BatchOfferedCard(),
                    SizedBox(height: 20),
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
              const FormInput(text: ""),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.addItem,
                  onPressed: () {},
                  color: ThemeColors.primary,
                  buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                  svgIcon: icons.Icons.bookIcon,
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

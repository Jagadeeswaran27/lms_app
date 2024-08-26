import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/batch_card.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/widgets/common/item_detail_card.dart';

class StudentItemDetailWidget extends StatelessWidget {
  const StudentItemDetailWidget({super.key, required this.course});

  final CourseModel course;

  void addToCart(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.cart.any((item) => item.courseId == course.courseId)) {
      showSnackbar(context, Strings.courseAlreadyInCart);
      return;
    }
    authProvider.addToCart(course);
    showSnackbar(context, Strings.courseAddedToCart);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemDetailCard(course: course),
            const SizedBox(height: 20),
            Text(
              Strings.aboutDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyMediumPrimary
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              course.aboutDescription,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.batchOferred,
              style: Theme.of(context)
                  .textTheme
                  .bodyMediumPrimary
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            BatchCard(
              batchDay: 'Weekend',
              batchTime: 'Morning',
              onBatchDayChanged: (String? newValue) {},
              onBatchTimeChanged: (String? newValue) {},
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.amountDetails,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumPrimary
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormInput(
              text: course.amount.toString(),
              hintText: course.amount.toString(),
              hasOfferTag: true,
              offer: "40",
              readOnly: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: IconTextButton(
                    iconHorizontalPadding: 7,
                    radius: 20,
                    text: Strings.addToCart,
                    onPressed: () => addToCart(context),
                    color: ThemeColors.primary,
                    buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                    svgIcon: icons.Icons.cartIconSvg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

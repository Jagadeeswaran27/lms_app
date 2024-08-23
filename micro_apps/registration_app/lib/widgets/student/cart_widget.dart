import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/student/cart_card.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXXXXX",
                  amount: "10000",
                  discount: 10,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Total Amount : ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMediumTitleBrownSemiBold,
                    ),
                    Text(
                      "Rs 30000",
                      style: Theme.of(context).textTheme.bodyMediumPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth * 0.7,
            height: 50,
            child: IconTextButton(
              iconHorizontalPadding: 7,
              radius: 20,
              text: Strings.proceedToCheckout,
              onPressed: () {
                Navigator.of(context).pushNamed(StudentRoutes.register);
              },
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.cartIconSvg,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

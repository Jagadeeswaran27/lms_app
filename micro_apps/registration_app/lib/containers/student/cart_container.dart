import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/widgets/student/cart_widget.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return CartWidget(courses: authProvider.cart);
  }
}

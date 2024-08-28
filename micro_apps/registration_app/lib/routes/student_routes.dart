import 'package:flutter/material.dart';

import 'package:registration_app/screens/student/cart_screen.dart';
import 'package:registration_app/screens/student/kid_registration_screen.dart';
import 'package:registration_app/screens/student/student_enrollment_screen.dart';
import 'package:registration_app/screens/student/student_item_detail_screen.dart';
import 'package:registration_app/screens/student/student_item_list_screen.dart';
import 'package:registration_app/screens/student/student_register_screen.dart';

class StudentRoutes {
  const StudentRoutes._();

  static const String itemList = '/';
  static const String itemDetail = '/item-detail';
  static const String cart = '/cart';
  static const String register = '/register';
  static const String enrollment = '/enrollment';
  static const String kidRegistration = '/kid-registration';

  static Map<String, WidgetBuilder> get buildStudentRoutes {
    return {
      itemList: (context) => const StudentItemListScreen(),
      itemDetail: (context) => const StudentItemDetailScreen(),
      cart: (context) => const CartScreen(),
      register: (context) => const StudentRegisterScreen(),
      enrollment: (context) => const StudentEnrollmentScreen(),
      kidRegistration: (context) => const KidRegistrationScreen(),
    };
  }

  static String get initialStudentRoute {
    return StudentRoutes.itemList;
  }
}

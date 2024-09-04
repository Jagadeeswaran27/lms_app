import 'package:attendance_app/screens/admin/item_detail_screen.dart';
import 'package:attendance_app/screens/admin/items_list_screen.dart';
import 'package:attendance_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:attendance_app/screens/admin/reception_enquiry_screen.dart';
import 'package:flutter/material.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String itemList = "item-list";
  static const String itemDetail = "item-detail";
  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      itemList: (context) => const ItemsListScreen(),
      itemDetail: (context) => const ItemDetailScreen(),
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen()
    };
  }

  static String get initialRoute {
    return AdminRoutes.itemList;
  }
}

import 'package:enquiry_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:enquiry_app/screens/admin/reception_enquiry_screen.dart';
import 'package:flutter/material.dart';

class AdminRoutes {
  AdminRoutes._();

  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.receptionEnquiry;
  }
}

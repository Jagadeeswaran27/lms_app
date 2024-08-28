import 'package:flutter/material.dart';
import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/resources/strings.dart';

import 'package:menu_app/widgets/admin/reception_enquiry_detail_widget.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ReceptionEnquiryDetailScreen extends StatelessWidget {
  const ReceptionEnquiryDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuLayout(
      topBarText: Strings.receptionEnquiry,
      child: ReceptionEnquiryDetailWidget(
        enquiry: EnquiryModel(
          description: 'saguwdg',
          enquiryId: '123',
          issue: 'fdsewfwe',
          priority: 'low',
          status: 'acknowledged',
          subject: 'English',
          type: 'Reception',
          userId: '123',
        ),
      ),
    );
  }
}

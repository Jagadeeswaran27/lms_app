import 'package:flutter/material.dart';
import 'package:attendance_app/models/enquiry/enquiry_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/routes/admin_routes.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/widgets/common/enquiry_card.dart';

class ReceptionEnquiryWidget extends StatelessWidget {
  const ReceptionEnquiryWidget({
    super.key,
    required this.isLoading,
    required this.enquiries,
  });

  final bool isLoading;
  final List<EnquiryModel> enquiries;

  void navigateToEnquiryDetailScreen(
      BuildContext context, EnquiryModel enquiry) {
    Navigator.of(context)
        .pushNamed(AdminRoutes.receptionEnquiryDetail, arguments: enquiry);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (enquiries.isEmpty) {
      return Center(
        child: Text(
          Strings.noEnquiriesFound,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ThemeColors.primary,
              ),
        ),
      );
    }

    return Container(
      width: screenSize.width * 0.90,
      margin: const EdgeInsets.only(top: 3),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: enquiries.length,
        itemBuilder: (context, index) {
          final enquiry = enquiries[index];
          return EnquiryCard(
            enquiry: enquiry,
            onTap: () => navigateToEnquiryDetailScreen(context, enquiry),
          );
        },
      ),
    );
  }
}

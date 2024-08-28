import 'package:flutter/material.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/widgets/common/enquiry_card.dart';

class ReceptionEnquiryWidget extends StatelessWidget {
  const ReceptionEnquiryWidget({super.key});

  void navigateToEnquiryDetailScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AdminRoutes.receptionEnquiryDetail);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.90,
      margin: const EdgeInsets.only(top: 3),
      child: ListView(
        children: [
          EnquiryCard(
            ticketNo: '113212332',
            subject: "English",
            imageUrl: Strings.url,
            onTap: () => navigateToEnquiryDetailScreen(context),
          ),
        ],
      ),
      // child: ListView.builder(
      //   padding: const EdgeInsets.all(0),
      //   itemCount: myEnquiries.length,
      //   itemBuilder: (context, index) {
      //     final enquiry = myEnquiries[index];
      //     return TicketCard(
      //       ticketNo: enquiry.enquiryId,
      //       subject: enquiry.subject,
      //       imageUrl: enquiry.fileUrl,
      //       onTap: () => navigateToMyTicketScreen(context, enquiry),
      //     );
      //   },
      // ),
    );
  }
}

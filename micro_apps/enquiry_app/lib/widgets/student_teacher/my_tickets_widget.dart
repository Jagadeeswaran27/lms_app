import 'package:flutter/material.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/routes/student_teacher_routes.dart';
import 'package:enquiry_app/widgets/common/ticket_card.dart';

class MyTicketsWidget extends StatelessWidget {
  const MyTicketsWidget({
    super.key,
    required this.myEnquiries,
  });

  final List<EnquiryModel> myEnquiries;

  void navigateToMyTicketScreen(BuildContext context, EnquiryModel enquiry) {
    Navigator.of(context).pushNamed(
      StudentTeacherRoutes.myTicket,
      arguments: enquiry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.90,
      margin: const EdgeInsets.only(top: 3),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: myEnquiries.length,
        itemBuilder: (context, index) {
          final enquiry = myEnquiries[index];
          return TicketCard(
            ticketNo: enquiry.enquiryId,
            subject: enquiry.subject,
            imageUrl: enquiry.fileUrl,
            onTap: () => navigateToMyTicketScreen(context, enquiry),
          );
        },
      ),
    );
  }
}

import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/widgets/student_teacher/my_ticket_widget.dart';
import 'package:flutter/material.dart';

class MyTicketContainer extends StatelessWidget {
  const MyTicketContainer({
    super.key,
    required this.enquiry,
  });

  final EnquiryModel enquiry;

  @override
  Widget build(BuildContext context) {
    return MyTicketWidget(enquiry: enquiry);
  }
}

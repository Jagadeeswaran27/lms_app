import 'package:enquiry_app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/core/services/enquiry/enquiry_service.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/providers/auth_provider.dart';
import 'package:enquiry_app/utils/error/show_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:enquiry_app/widgets/student_teacher/my_tickets_widget.dart';

class MyTicketsContainer extends StatefulWidget {
  const MyTicketsContainer({super.key});

  @override
  State<MyTicketsContainer> createState() => _MyTicketsContainerState();
}

class _MyTicketsContainerState extends State<MyTicketsContainer> {
  EnquiryService enquiryService = EnquiryService();
  List<EnquiryModel> _myEnquiries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMyEnquiries();
  }

  Future<void> fetchMyEnquiries() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.currentUser!.uid;
    String instituteId = '123456';
    try {
      _myEnquiries = await enquiryService.getMyEnquiries(userId, instituteId);
    } catch (e) {
      showSnackbar(context, "Error fetching tickets");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_myEnquiries.isEmpty) {
      return Center(
        child: Text(
          "No tickets",
          style: Theme.of(context).textTheme.bodyMediumPrimary,
        ),
      );
    }

    return MyTicketsWidget(
      myEnquiries: _myEnquiries,
    );
  }
}

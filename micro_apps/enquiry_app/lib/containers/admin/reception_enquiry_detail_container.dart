import 'package:enquiry_app/core/services/enquiry/admin_enquiry_service.dart';
import 'package:enquiry_app/core/services/enquiry/admin_messages_service.dart';
import 'package:flutter/material.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/models/enquiry/message_model.dart';
import 'package:enquiry_app/providers/auth_provider.dart';
import 'package:enquiry_app/widgets/admin/reception_enquiry_detail_widget.dart';
import 'package:provider/provider.dart';

class ReceptionEnquiryDetailContainer extends StatefulWidget {
  const ReceptionEnquiryDetailContainer({
    super.key,
    required this.enquiry,
  });
  final EnquiryModel enquiry;

  @override
  State<ReceptionEnquiryDetailContainer> createState() =>
      _ReceptionEnquiryDetailContainerState();
}

class _ReceptionEnquiryDetailContainerState
    extends State<ReceptionEnquiryDetailContainer> {
  AdminMessagesService messagesService = AdminMessagesService();
  bool _isLoading = false;
  List<MessageModel> messages = [];
  final AdminEnquiryService enquiryService = AdminEnquiryService();

  Future<void> fetchMessages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      messages = await messagesService.fetchMessages(
        authProvider.currentUser!.institute[0],
        widget.enquiry.enquiryId,
      );
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> sendMessage(String message) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final response = await messagesService.sendMessage(
        message,
        authProvider.currentUser!.institute[0],
        "Admin",
        widget.enquiry.enquiryId,
      );
      if (response) {
        setState(() {
          messages.add(MessageModel(
            messageText: message,
            senderRole: "Admin",
            // Add other relevant fields as needed
          ));
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? RefreshIndicator(
            onRefresh: fetchMessages,
            child: ReceptionEnquiryDetailWidget(
              enquiry: widget.enquiry,
              isLoading: _isLoading,
              messages: messages,
              onSendMessage: sendMessage,
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

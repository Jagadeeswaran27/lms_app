import 'package:flutter/material.dart';
import 'package:menu_app/core/services/enquiry/enquiry_service.dart';

import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/common/choose_file_button.dart';
import 'package:menu_app/widgets/common/enquiry_reception_title_card.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/full_screen_image_viewer.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/widgets/common/status_progress_indicator.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class ReceptionEnquiryDetailWidget extends StatefulWidget {
  const ReceptionEnquiryDetailWidget({
    super.key,
    required this.enquiry,
  });

  final EnquiryModel enquiry;

  @override
  State<ReceptionEnquiryDetailWidget> createState() =>
      _ReceptionEnquiryDetailWidgetState();
}

class _ReceptionEnquiryDetailWidgetState
    extends State<ReceptionEnquiryDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final enquiryService = EnquiryService();
    bool _isLoading = false;
    final isAcknowledged = widget.enquiry.status == 'acknowledged';
    final isResolved = widget.enquiry.status == 'resolved';
    final Size screenSize = MediaQuery.of(context).size;

    void onResolveEnquiry() async {
      setState(() {
        _isLoading = true;
      });
      final status =
          await enquiryService.resolveEnquiry(widget.enquiry.enquiryId);
      setState(() {
        _isLoading = false;
      });

      if (status) {
        showSnackbar(context, 'Enquiry resolved successfully');
        Navigator.of(context).pop();
      } else {
        showSnackbar(context, 'Failed to resolve enquiry');
      }
    }

    return Column(
      children: [
        EnquiryReceptionTitleCard(
          name: widget.enquiry.enquiryId,
          isTicket: true,
          priority: widget.enquiry.priority,
        ),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.facingIssue,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.enquiry.issue,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.subject,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.enquiry.subject,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.describedIssue,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.enquiry.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        Strings.view,
                        style: Theme.of(context).textTheme.bodyLargeTitleBrown,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        child: ChooseFileButton(
                          onTap: () {
                            widget.enquiry.fileUrl != null
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => FullScreenImageViewer(
                                        imageUrl: widget.enquiry.fileUrl!,
                                      ),
                                    ),
                                  )
                                : null;
                          },
                          text: Strings.file,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.enquiry.fileUrl != null ? '1 file' : 'no file',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: screenSize.width * 0.7,
                    child: IconTextButton(
                      text: Strings.resolve,
                      onPressed: onResolveEnquiry,
                      color: ThemeColors.primary,
                      iconHorizontalPadding: 5,
                      svgIcon: icons.Icons.resolve,
                      iconColor: ThemeColors.white,
                      isLoading: _isLoading,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.status,
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: FormInput(
                              text: "",
                              hintText: isAcknowledged || isResolved
                                  ? Strings.acknowledged
                                  : Strings.toAcknowledge,
                              readOnly: true,
                              fillColor: isAcknowledged || isResolved
                                  ? ThemeColors.primary
                                  : null,
                              hintTextStyle: isAcknowledged || isResolved
                                  ? Theme.of(context).textTheme.bodyMedium
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            child: FormInput(
                              text: "",
                              hintText: isResolved
                                  ? Strings.resolved
                                  : Strings.toResolve,
                              readOnly: true,
                              fillColor:
                                  isResolved ? ThemeColors.primary : null,
                              hintTextStyle: isResolved
                                  ? Theme.of(context).textTheme.bodyMedium
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      StatusProgressIndicator(
                        isAcknowledged:
                            isAcknowledged || isResolved ? true : false,
                        isResolved: isResolved ? true : false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

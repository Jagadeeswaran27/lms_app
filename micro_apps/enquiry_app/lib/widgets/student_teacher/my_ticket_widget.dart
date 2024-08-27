import 'package:enquiry_app/widgets/common/full_screen_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/form_input.dart';
import 'package:enquiry_app/widgets/common/status_progress_indicator.dart';
import 'package:enquiry_app/widgets/student_teacher/choose_file_button.dart';
import 'package:enquiry_app/widgets/student_teacher/enquiry_reception_title_card.dart';

class MyTicketWidget extends StatelessWidget {
  const MyTicketWidget({
    super.key,
    required this.enquiry,
  });

  final EnquiryModel enquiry;
  @override
  Widget build(BuildContext context) {
    final isAcknowledged = enquiry.status == 'acknowledged';
    final isResolved = enquiry.status == 'resolved';
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        EnquiryReceptionTitleCard(
          name: enquiry.enquiryId,
          isTicket: true,
          priority: enquiry.priority,
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
                        enquiry.issue,
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
                        enquiry.subject,
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
                        enquiry.description,
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
                            enquiry.fileUrl != null
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => FullScreenImageViewer(
                                        imageUrl: enquiry.fileUrl!,
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
                        enquiry.fileUrl != null ? '1 file' : 'no file',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
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

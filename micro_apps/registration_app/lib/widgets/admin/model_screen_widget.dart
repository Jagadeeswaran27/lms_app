import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/custom_dashed_input.dart';

class ModelScreenWidget extends StatefulWidget {
  const ModelScreenWidget({super.key});

  @override
  State<ModelScreenWidget> createState() => _ModelScreenWidgetState();
}

class _ModelScreenWidgetState extends State<ModelScreenWidget> {
  List<File?> _image = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _image = List.filled(5, null);
  }

  void onMediaSelected(ImageSource imageSource, int index) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image[index] = image;
    });
  }

  void onSaveMedia(BuildContext context) {
    if (_image.isEmpty) return;
    //send to container
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: screenSize.width * 0.9,
      child: Form(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                child: _image[index] == null
                    ? CustomDashedInput(
                        text: Strings.gallery,
                        onTap: () =>
                            onMediaSelected(ImageSource.gallery, index),
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                FileImage(File(_image[index]!.path)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Image ${index + 1} uploaded',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumTitleBrown,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location_app/constants/constants.dart';
import 'package:location_app/models/location_model.dart';

import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:location_app/widgets/common/form_input.dart';
import 'package:location_app/widgets/common/icon_text_button.dart';
import 'package:location_app/resources/icons.dart' as icons;
import 'package:google_places_flutter/google_places_flutter.dart';

class AdminLocationWidget extends StatefulWidget {
  final Function(LocationModel) storeLocation;
  final bool isLoading;

  const AdminLocationWidget({
    super.key,
    required this.storeLocation,
    this.isLoading = false,
  });

  @override
  State<AdminLocationWidget> createState() => _AdminLocationWidgetState();
}

class _AdminLocationWidgetState extends State<AdminLocationWidget> {
  TextEditingController controller = TextEditingController();
  LocationModel? locationData;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.centerName,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const FormInput(text: Strings.fullName),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.searchOnGoogleMaps,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              googleAPIKey: constants.apiKey,
              boxDecoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.white,
              ),
              inputDecoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color: ThemeColors.authPrimary,
                    width: 1,
                  ),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.search),
                ),
                labelStyle: Theme.of(context).textTheme.displaySmall,
                hintText: 'Search location',
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ThemeColors.primary),
              ),
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          prediction.description ?? "",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                        ),
                      )
                    ],
                  ),
                );
              },
              isCrossBtnShown: false,
              textStyle: TextStyle(color: ThemeColors.primary),
              debounceTime: 300,
              countries: const ["IN"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) async {
                locationData = LocationModel(
                  name: prediction.description ?? "",
                  placeId: prediction.placeId ?? "",
                  latitude: double.tryParse(prediction.lat ?? '') ?? 0.0,
                  longitude: double.tryParse(prediction.lng ?? '') ?? 0.0,
                );
              },
              seperatedBuilder: Divider(
                color: ThemeColors.primary.withOpacity(0.7),
              ),
              itemClick: (Prediction prediction) {
                controller.text = prediction.description ?? "";
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description?.length ?? 0),
                );
              },
            ),
            const SizedBox(height: 30),
            Text(
              Strings.or,
              style: Theme.of(context).textTheme.titleSmallTitleBrown,
            ),
            Row(
              children: [
                Text(
                  Strings.enterYourLocation,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 50,
              child: IconTextButton(
                text: Strings.useMyLocation,
                onPressed: () {},
                color: ThemeColors.cardColor,
                iconHorizontalPadding: 5,
                buttonTextStyle: Theme.of(context).textTheme.titleSmall,
                svgIcon: icons.Icons.location,
                iconBackgroundColor: ThemeColors.primary,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              Strings.or,
              style: Theme.of(context).textTheme.titleSmallTitleBrown,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  Strings.enterYourLocationOrLink,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FormInput(text: ""),
            const SizedBox(height: 30),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 50,
              child: IconTextButton(
                isLoading: widget.isLoading,
                iconHorizontalPadding: 7,
                radius: 20,
                text: Strings.saveLocation,
                onPressed: () {
                  if (locationData != null) {
                    widget.storeLocation(locationData!);
                  }
                },
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                svgIcon: icons.Icons.cap,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

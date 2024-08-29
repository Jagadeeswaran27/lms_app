import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location_app/constants/constants.dart';
import 'package:location_app/models/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:location_app/widgets/common/form_input.dart';
import 'package:location_app/widgets/common/icon_text_button.dart';
import 'package:location_app/resources/icons.dart' as icons;
import 'package:google_places_flutter/google_places_flutter.dart';
import 'dart:convert';

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
  TextEditingController urlController = TextEditingController();
  LocationModel? locationData;

  Future<void> _extractFromGoogleMapsLink() async {
    String url =
        "https://www.google.com/maps/place/Asha+Tiffins/@12.9614549,77.7108679,15z/data=!4m6!3m5!1s0x3bae122463d8d8b3:0x572809340116f59d!8m2!3d12.9645397!4d77.7144272!16s%2Fg%2F11hcysbb83?entry=ttu&g_ep=EgoyMDI0MDgyNi4wIKXMDSoASAFQAw%3D%3D";

    RegExp regex = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
    Match? match = regex.firstMatch(url);

    if (match != null) {
      double lat = double.parse(match.group(1)!);
      double lng = double.parse(match.group(2)!);

      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${constants.apiKey}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final address = data['results'][0]['formatted_address'];
          final placeId = data['results'][0]['place_id'];

          setState(() {
            locationData = LocationModel(
              name: address,
              placeId: placeId,
              latitude: lat,
              longitude: lng,
            );
            controller.text = address;
          });
        }
      }
    } else {
      print('Invalid Google Maps link format');
    }
  }

  Future<void> _useMyLocation() async {
    await _extractFromGoogleMapsLink();
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle permission denied
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition();
      // Use Google Geocoding API to get address details
      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${constants.apiKey}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final address = data['results'][0]['formatted_address'];
          final placeId = data['results'][0]['place_id'];

          // Update locationData
          setState(() {
            locationData = LocationModel(
              name: address,
              placeId: placeId,
              latitude: position.latitude,
              longitude: position.longitude,
            );
            controller.text = address;
          });
        }
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      // Handle errors
      print("Error getting location: $e");
    }
  }

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
                onPressed: _useMyLocation,
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
            FormInput(
              controller: urlController,
              text: "",
              suffixIcon: GestureDetector(
                onTap: _extractFromGoogleMapsLink,
                child: const Icon(Icons.search),
              ),
            ),
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
                    locationData = null;
                    urlController.clear();
                    controller.clear();
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

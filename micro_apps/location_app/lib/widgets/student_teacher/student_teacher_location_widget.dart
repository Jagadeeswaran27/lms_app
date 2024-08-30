import 'package:flutter/material.dart';
import 'package:location_app/constants/constants.dart';

import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:location_app/widgets/common/form_input.dart';
import 'package:location_app/resources/icons.dart' as icons;
import 'package:location_app/widgets/common/icon_text_button.dart';
import 'package:location_app/widgets/common/svg_lodder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class StudentTeacherLocationWidget extends StatefulWidget {
  const StudentTeacherLocationWidget({super.key});

  @override
  State<StudentTeacherLocationWidget> createState() =>
      _StudentTeacherLocationWidgetState();
}

class _StudentTeacherLocationWidgetState
    extends State<StudentTeacherLocationWidget> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  LatLng sourceLocation = LatLng(37.7749, -122.4194); // Example: San Francisco
  LatLng destinationLocation =
      LatLng(34.0522, -118.2437); // Example: Los Angeles

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _getPolyline();
  }

  void _addMarkers() {
    markers.add(Marker(
      markerId: MarkerId('source'),
      position: sourceLocation,
    ));
    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
    ));
  }

  void _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey:
          constants.apiKey, // Use the API key from your constants file
      request: PolylineRequest(
        origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        destination: PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylines.add(Polyline(
        polylineId: const PolylineId('poly'),
        color: const Color.fromARGB(255, 40, 122, 198),
        points:
            result.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      ));
      setState(() {});
    } else {
      print('Error: ${result.errorMessage}');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result.errorMessage}')),
      );
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
                  Strings.searchOnGoogleMaps,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FormInput(
              text: "",
              suffixIcon: SVGLoader(
                image: icons.Icons.search,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 500,
              child: Builder(
                builder: (BuildContext context) {
                  try {
                    return GoogleMap(
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      initialCameraPosition: CameraPosition(
                        target: sourceLocation,
                        zoom: 12,
                      ),
                      markers: markers,
                      polylines: polylines,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                    );
                  } catch (e) {
                    print('Error initializing map: $e');
                    return const Center(child: Text('Error loading map'));
                  }
                },
              ),
            ),
            // SizedBox(
            //   width: screenSize.width * 0.7,
            //   height: 50,
            //   child: IconTextButton(
            //     iconHorizontalPadding: 7,
            //     radius: 20,
            //     text: Strings.fetchInstitutes,
            //     onPressed: () {
            //       // Navigator.of(context).pushNamed(StudentRoutes.register);
            //     },
            //     color: ThemeColors.primary,
            //     buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
            //     svgIcon: icons.Icons.cap,
            //   ),
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

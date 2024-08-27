import 'package:flutter/material.dart';

import 'package:location_app/screens/admin/admin_location_screen.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String location = '/location';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      location: (context) => const AdminLocationScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.location;
  }
}

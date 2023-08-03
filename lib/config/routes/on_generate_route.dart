import 'package:flutter/material.dart';

import 'package:classroom_manager/feature/class_room/presentation/pages/dashboard.dart';

Route<dynamic>? onGenerateRoute(
  RouteSettings routeSettings,
  
) {
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeSettings.name) {
        case DashboardScreen.routeName:
          return const DashboardScreen();

        default:
          return const DashboardScreen();
      }
    },
  );
}

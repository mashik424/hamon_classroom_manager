import 'package:classroom_manager/feature/class_room/presentation/pages/splash.dart';
import 'package:flutter/material.dart';

import 'package:classroom_manager/feature/class_room/presentation/pages/classroom.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/classrooms.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/dashboard.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/student.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/students.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/subject.dart';
import 'package:classroom_manager/feature/class_room/presentation/pages/subjects.dart';

Route<dynamic>? onGenerateRoute(
  RouteSettings routeSettings,
) {
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeSettings.name) {
        case SplashScreen.routeName:
          return const SplashScreen();

        case DashboardScreen.routeName:
          return const DashboardScreen();

        case ClassroomsScreen.routeName:
          return const ClassroomsScreen();

        case ClassroomScreen.routeName:
          final settings = routeSettings.arguments as Map<String, dynamic>?;
          return ClassroomScreen(
            id: settings?['id'] as int,
            name: settings?['name'] as String? ?? '',
          );

        case SubjectsScreen.routeName:
          return const SubjectsScreen();

        case SubjectScreen.routeName:
          final settings = routeSettings.arguments as Map<String, dynamic>?;
          return SubjectScreen(
            id: settings?['id'] as int,
            name: settings?['name'] as String? ?? '',
          );

        case StudentsScreen.routeName:
          return const StudentsScreen();

        case StudentScreen.routeName:
          final settings = routeSettings.arguments as Map<String, dynamic>?;
          return StudentScreen(
            id: settings?['id'] as int,
            name: settings?['name'] as String? ?? '',
          );

        default:
          return const DashboardScreen();
      }
    },
  );
}

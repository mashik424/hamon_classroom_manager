import 'package:flutter/material.dart';

import '../widgets/dash_tile.dart';
import 'classrooms.dart';
import 'students.dart';
import 'subjects.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        children: [
          DashTile(
            iconPath: 'assets/svg/classroom.svg',
            label: 'Classrooms',
            onTap: () => Navigator.of(context).pushNamed(
              ClassroomsScreen.routeName,
            ),
          ),
          DashTile(
            iconPath: 'assets/svg/student.svg',
            label: 'Students',
            onTap: () => Navigator.of(context).pushNamed(
              StudentsScreen.routeName,
            ),
          ),
          DashTile(
            iconPath: 'assets/svg/subject.svg',
            label: 'Subjects',
            onTap: () => Navigator.of(context).pushNamed(
              SubjectsScreen.routeName,
            ),
          ),
        ],
      ),
    );
  }
}

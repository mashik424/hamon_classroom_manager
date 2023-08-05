// ignore_for_file: use_build_context_synchronously

import 'package:classroom_manager/feature/class_room/presentation/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/classrooms_notifier.dart';
import '../providers/registrations_notifier.dart';
import '../providers/students_notifier.dart';
import '../providers/subjects_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _loadLists(),
    );
    super.initState();
  }

  void _loadLists() async {
    await ref.read(classroomsNotifier).getClasssrooms(context);
    await ref.read(studentsNotifier).getStudents(context);
    await ref.read(subjectsNotifier).getSubjects(context);
    await ref.read(registrationsNotifier).getRegistrations(context);

    Navigator.of(context).popAndPushNamed(
      DashboardScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Center(
            child: SizedBox.square(
              dimension: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(
                'assets/images/flutter_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(flex: 5),
          const CircularProgressIndicator(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

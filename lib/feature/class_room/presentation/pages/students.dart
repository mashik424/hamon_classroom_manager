import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/students_notifier.dart';
import '../widgets/student_item.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  static const String routeName = '/students';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(studentsNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: controller.students.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(studentsNotifier).getStudents(
                    context,
                  ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 26.0,
                ),
                itemCount: controller.students.length,
                itemBuilder: (context, index) => StudentItem(
                  student: controller.students[index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
    );
  }
}

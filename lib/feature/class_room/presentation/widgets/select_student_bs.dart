import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/students_notifier.dart';
import 'student_item.dart';

class SelectStudentBS extends ConsumerWidget {
  const SelectStudentBS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(studentsNotifier);
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.8,
      initialChildSize: 0.8,
      builder: (context, scrollController) => ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 26.0,
        ),
        itemCount: controller.students.length,
        itemBuilder: (context, index) => StudentItem(
          student: controller.students[index],
          onTap: () => Navigator.of(context).pop(controller.students[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
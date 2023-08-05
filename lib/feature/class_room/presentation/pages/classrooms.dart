import 'package:classroom_manager/feature/class_room/data/models/subject.dart';
import 'package:classroom_manager/feature/class_room/presentation/providers/subjects_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/classrooms_notifier.dart';
import '../widgets/classroom_item.dart';

class ClassroomsScreen extends ConsumerWidget {
  const ClassroomsScreen({super.key});

  static const String routeName = '/classrooms';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(classroomsNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classrooms'),
      ),
      body: controller.classrooms.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(classroomsNotifier).getClasssrooms(
                    context,
                  ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 26.0,
                ),
                itemCount: controller.classrooms.length,
                itemBuilder: (context, index) {
                  SubjectModel? subject;

                  try {
                    subject = ref.read(subjectsNotifier).subjects.firstWhere(
                        (element) =>
                            element.id == controller.classrooms[index].subject);
                  } catch (e) {
                    //
                  }
                  return ClassroomItem(
                    classroom: controller.classrooms[index],
                    subject: subject,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
    );
  }
}

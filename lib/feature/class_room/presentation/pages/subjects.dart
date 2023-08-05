import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/subjects_notifier.dart';
import '../widgets/subject_item.dart';

class SubjectsScreen extends ConsumerWidget {
  const SubjectsScreen({super.key});

  static const String routeName = '/subjects';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(subjectsNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      body: controller.subjects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(subjectsNotifier).getSubjects(
                    context,
                  ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 26.0,
                ),
                itemCount: controller.subjects.length,
                itemBuilder: (context, index) => SubjectItem(
                  subject: controller.subjects[index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
    );
  }
}

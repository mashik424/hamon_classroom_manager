import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/subjects_notifier.dart';
import 'subject_item.dart';

class SelectSubjectBS extends ConsumerWidget {
  const SelectSubjectBS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(subjectsNotifier);
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.8,
      initialChildSize: 0.8,
      builder: (context, scrollController) => ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 26.0,
        ),
        itemCount: controller.subjects.length,
        itemBuilder: (context, index) => SubjectItem(
          subject: controller.subjects[index],
          onTap: () => Navigator.of(context).pop(controller.subjects[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
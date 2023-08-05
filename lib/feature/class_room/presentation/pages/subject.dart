import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:classroom_manager/feature/class_room/data/models/subject.dart';

import '../providers/subjects_notifier.dart';
import '../widgets/name_and_value.dart';

class SubjectScreen extends ConsumerWidget {
  const SubjectScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  static const String routeName = '/subject';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: FutureBuilder<SubjectModel>(
        future: ref.read(subjectsNotifier).getSubject(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                NameAndValue(
                  name: "Teacher",
                  value: snapshot.data!.teacher,
                ),
                NameAndValue(
                  name: "Credits",
                  value: snapshot.data!.credits.toString(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

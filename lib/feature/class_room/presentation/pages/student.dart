import 'package:classroom_manager/feature/class_room/data/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/students_notifier.dart';
import '../widgets/name_and_value.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  static const String routeName = '/student';

  @override
  ConsumerState<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder<StudentModel>(
        future: ref.read(studentsNotifier).getStudent(widget.id),
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
                  name: "Age",
                  value: snapshot.data!.age.toString(),
                ),
                NameAndValue(
                  name: "Email",
                  value: snapshot.data!.email,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

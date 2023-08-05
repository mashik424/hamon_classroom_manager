import 'package:classroom_manager/feature/class_room/data/models/classroom.dart';
import 'package:classroom_manager/feature/class_room/data/models/subject.dart';
import 'package:flutter/material.dart';

import '../pages/classroom.dart';

class ClassroomItem extends StatelessWidget {
  const ClassroomItem({
    super.key,
    required this.classroom,
    this.subject,
  });

  final ClassroomModel classroom;
  final SubjectModel? subject;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ClassroomScreen.routeName,
        arguments: {
          'id': classroom.id,
          'name': classroom.name,
        },
      ),
      child: Card(
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                classroom.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Layout :"),
                        const Text("Size :"),
                        if (subject != null) const Text("Subject :"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(classroom.layout),
                        Text(classroom.size.toString()),
                        if (subject != null) Text(subject!.name),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

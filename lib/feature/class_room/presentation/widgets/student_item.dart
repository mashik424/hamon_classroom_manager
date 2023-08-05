import 'package:classroom_manager/feature/class_room/data/models/student.dart';
import 'package:flutter/material.dart';

import '../pages/student.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student, this.onTap});

  final StudentModel student;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => Navigator.of(context).pushNamed(
                StudentScreen.routeName,
                arguments: {
                  'id': student.id,
                  'name': student.name,
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
                student.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Age :"),
                        Text("Email :"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(student.age.toString()),
                        FittedBox(child: Text(student.email)),
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

import 'package:flutter/material.dart';

import 'package:classroom_manager/feature/class_room/data/models/subject.dart';

import '../pages/subject.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({super.key, required this.subject, this.onTap});

  final SubjectModel subject;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? () => Navigator.of(context).pushNamed(
                SubjectScreen.routeName,
                arguments: {
                  'id': subject.id,
                  'name': subject.name,
                },
              )
          : onTap!,
      child: Card(
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject.name,
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
                        Text("Credits :"),
                        Text("Teacher :"),
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
                        Text(subject.credits.toString()),
                        FittedBox(child: Text(subject.teacher)),
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

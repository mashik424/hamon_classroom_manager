import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:classroom_manager/feature/class_room/data/models/classroom.dart';
import 'package:classroom_manager/feature/class_room/data/models/student.dart';
import 'package:classroom_manager/feature/class_room/data/models/subject.dart';
import 'package:classroom_manager/feature/class_room/domain/params/create_registration.dart';

import '../providers/classrooms_notifier.dart';
import '../providers/registrations_notifier.dart';
import '../providers/students_notifier.dart';
import '../providers/subjects_notifier.dart';
import '../widgets/student_item.dart';
import '../widgets/subject_item.dart';

class ClassroomScreen extends ConsumerStatefulWidget {
  const ClassroomScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  static const String routeName = '/classroom';

  @override
  ConsumerState<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends ConsumerState<ClassroomScreen> {
  ClassroomModel? classroom;
  Exception? error;

  SubjectModel? subject;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => getClasssroom(),
    );
    super.initState();
  }

  Future<void> getClasssroom({bool silent = false}) async {
    if (!silent) {
      classroom = null;
    }
    error = null;
    setState(() {});

    try {
      classroom = await ref.read(classroomsNotifier).getClasssroom(widget.id);
    } on Exception catch (e) {
      error = e;
    }

    try {
      subject = ref
          .read(subjectsNotifier)
          .subjects
          .firstWhere((element) => element.id == classroom!.subject);
    } catch (e) {
      //
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Builder(
        builder: (context) {
          if (error != null) {
            return Center(
              child: Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            );
          } else if (classroom == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _body(classroom!);
          }
        },
      ),
    );
  }

  Widget _body(ClassroomModel classroom) {
    final registrations = ref.watch(registrationsNotifier);
    final students = subject == null
        ? null
        : registrations.studentsOf(subject: subject!.id).entries.toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameAndValue(
            name: "Layout",
            value: classroom.layout,
          ),
          NameAndValue(
            name: "Size",
            value: classroom.size.toString(),
          ),
          NameAndValue(
            name: "Subject",
            valueWidget: classroom.subject != null
                ? Row(
                    children: [
                      Text(
                        " : ${classroom.subject}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        onPressed: _assignSubject,
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                        ),
                        icon: SvgPicture.asset(
                          'assets/svg/change.svg',
                          height: 24.0,
                          width: 24.0,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onBackground,
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        " : ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (ref.watch(classroomsNotifier).allocating)
                        const SizedBox.square(
                          dimension: 24.0,
                          child: CircularProgressIndicator(),
                        )
                      else
                        ElevatedButton(
                          onPressed: _assignSubject,
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Assign Subject',
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 12),
          if (students != null) ...[
            Text(
              'Students',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: students.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}. ${students[index].value.name}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    onPressed: () => _deleteRegistration(students[index].key),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    icon: const Icon(Icons.delete, size: 24.0),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 2),
            ),
            const SizedBox(height: 12),
            if (registrations.creating || registrations.deleting)
              const Center(
                child: SizedBox.square(
                  dimension: 24.0,
                  child: CircularProgressIndicator(),
                ),
              )
            else
              ElevatedButton(
                onPressed: _registerStudent,
                child: const Text('Add Student'),
              ),
          ]
        ],
      ),
    );
  }

  Future<void> _deleteRegistration(int id) async {
    final result =
        // ignore: use_build_context_synchronously
        await ref.read(registrationsNotifier).deleteRegistration(
              context,
              id: id,
            );

    if (result) {
      getClasssroom(silent: true);
    }
  }

  Future<void> _registerStudent() async {
    final student = await showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => const SelectStudentBS(),
    );

    if (student is StudentModel) {
      final result =
          // ignore: use_build_context_synchronously
          await ref.read(registrationsNotifier).createRegistration(context,
              params: CreateRegistrationParams(
                student: student.id,
                subject: subject!.id,
              ));

      if (result) {
        getClasssroom(silent: true);
      }
    }
  }

  Future<void> _assignSubject() async {
    final subject = await showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => const SelectSubjectBS(),
    );
    if (subject is SubjectModel) {
      // ignore: use_build_context_synchronously
      final result = await ref.read(classroomsNotifier).assignSubject(
            context,
            classRoom: widget.id,
            subject: subject.id,
          );

      if (result) {
        getClasssroom(silent: true);
      }
    }
  }
}

class NameAndValue extends StatelessWidget {
  const NameAndValue({
    super.key,
    required this.name,
    this.value = '',
    this.valueWidget,
  });

  final String name;
  final String value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          flex: 7,
          child: valueWidget ??
              Text(
                " : $value",
                style: Theme.of(context).textTheme.titleMedium,
              ),
        ),
      ],
    );
  }
}

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

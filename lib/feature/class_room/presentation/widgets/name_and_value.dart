import 'package:flutter/material.dart';

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
                style: Theme.of(context).textTheme.titleSmall,
              ),
        ),
      ],
    );
  }
}
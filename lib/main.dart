import 'package:classroom_manager/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  await initializeDependancies();
  runApp(const ProviderScope(child: MyApp()));
}

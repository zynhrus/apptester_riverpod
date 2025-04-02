import 'package:app_riverpod/app.dart';
import 'package:app_riverpod/core/log_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmf_dsl/dsl_service/dsl_service.dart';

void main() {
  DSLService().setProject(Project.kpm);

  runApp(ProviderScope(
    observers: [LogObserver()],
    child: const MyApp(),
  ));
}
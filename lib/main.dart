import 'package:app_riverpod/app.dart';
import 'package:app_riverpod/core/log_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    observers: [LogObserver()],
    child: const MyApp(),
  ));
}
import 'package:app_riverpod/module/submission/common/stepper/stepper_notifier.dart';
import 'package:app_riverpod/module/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_input.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_output.dart';
import 'package:app_riverpod/module/submission/submission_3/state/submission_3_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_3_notifier.g.dart';

@riverpod
class Submission3Notifier extends _$Submission3Notifier {
  late final StepperNotifier stepperNotifier;

  @override
  Submission3State build() {
    stepperNotifier = ref.read(stepperNotifierProvider.notifier);
    return Submission3State.initial();
  }

  void onInitialized(Submission3Input input) {
    state = state.success(data: input);
  }

  void onNavigatedBack(BuildContext context){
    stepperNotifier.previousStep();
    ref.read(submission3RouteProvider).pop(context, output: const Submission3Output(result: "Submission navigate back"));
  }

  Future<void> onSubmited(BuildContext context) async {
    state.loading();
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      ref.read(submission3RouteProvider).offToHome(context);
    });
  }
}
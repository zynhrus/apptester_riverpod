import 'package:app_riverpod/core/state/base_state.dart';
import 'package:app_riverpod/module/submission/common/district/notifier/district_notifier.dart';
import 'package:app_riverpod/module/submission/common/province/notifier/province_notifier.dart';
import 'package:app_riverpod/module/submission/common/stepper/stepper_notifier.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/state/submission_1_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_1_notifier.g.dart';

@riverpod
class Submission1Notifier extends _$Submission1Notifier {
  // If needed, you can use other notifiers inside your notifier.
  // Declare notifier as global variable when it is used in all over class
  late final StepperNotifier _stepperNotifier;

  @override
  Submission1State build() {
    _stepperNotifier = ref.read(stepperNotifierProvider.notifier);
    return Submission1State.initial();
  }

  void onInitialized(String customerId) {
    _stepperNotifier.jumpToStep(1);
    state = state.success(data: customerId);
  }

  void onNavigatedBack(BuildContext context){
    ref.read(submission1RouteProvider).pop(context, output: const Submission1Output(result: "navigate back from submission"));
  }

  Future<Submission2Output?> onNavigatedToSubmission2(BuildContext context) async {
    // Only declare notifiers as local variable when it is used in only one method
    final provinceState = ref.read(provinceNotifierProvider);
    final districtState = ref.read(districtNotifierProvider);

    if (provinceState.data.selectedProvince == null || districtState.data.selectedDistrict == null) return null;

    state = state.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(stateStatus: StateStatus.success);

    final input = Submission2Input(
      customerId: state.data,
      province: provinceState.data.selectedProvince!,
      district: districtState.data.selectedDistrict!,
    );

    _stepperNotifier.nextStep();
    return await ref.read(submission1RouteProvider).navigateToSubmission2(context, input);
  }

  // Future<Submission3Output?> onNavigatedToSubmission3(BuildContext context) async {
    // final input = Submission3Input(formData: "Form Data from submission 1");
    // stepperNotifier.jumpToStep(3);
    // return await ref.read(submission1RouteProvider).navigateToSubmission3(context, input);
  // }
}
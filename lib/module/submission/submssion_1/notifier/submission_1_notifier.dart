import 'package:app_riverpod/core/extensions/date_extension.dart';
import 'package:app_riverpod/core/state/base_state.dart';
import 'package:app_riverpod/module/submission/common/district/district_dropdown.dart';
import 'package:app_riverpod/module/submission/common/district/notifier/district_notifier.dart';
import 'package:app_riverpod/module/submission/common/province/notifier/province_notifier.dart';
import 'package:app_riverpod/module/submission/common/province/province_dropdown.dart';
import 'package:app_riverpod/module/submission/common/stepper/stepper_notifier.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/constants/submission_1_key_constants.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/state/submission_1_state.dart';
import 'package:app_riverpod/module/submission/submssion_1/widgets/address_widget.dart';
import 'package:app_riverpod/module/submission/submssion_1/widgets/end_date_widget.dart';
import 'package:app_riverpod/module/submission/submssion_1/widgets/rt_rw_widget.dart';
import 'package:app_riverpod/module/submission/submssion_1/widgets/start_date_widget.dart';
import 'package:app_riverpod/module/submission/submssion_1/widgets/till_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:fmf_dsl/fl_form_framework/fl_form_framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_1_notifier.g.dart';

@riverpod
class Submission1Notifier extends _$Submission1Notifier {
  // If needed, you can use other notifiers inside your notifier.
  // Declare notifier as global variable when it is used in all over class
  late final StepperNotifier _stepperNotifier;

  final FormFactory formFactory = FormFactory();

  final addressController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final villageController = TextEditingController();
  final villageSearchController = TextEditingController();
  final homeStatusController = TextEditingController();
  final startMonthController = TextEditingController();
  final startYearController = TextEditingController();
  final endMonthController = TextEditingController();
  final endYearController = TextEditingController();
  final branchController = TextEditingController();

  bool isShowTillError = false;

  @override
  Submission1State build() {
    _stepperNotifier = ref.read(stepperNotifierProvider.notifier);
    return Submission1State.initial();
  }

  void dispose() {
    addressController.dispose();
    rtController.dispose();
    rwController.dispose();
    villageController.dispose();
    villageSearchController.dispose();
    homeStatusController.dispose();
    startMonthController.dispose();
    startYearController.dispose();
    endMonthController.dispose();
    endYearController.dispose();
    branchController.dispose();
  }

  void onInitialized(String customerId) {
    _stepperNotifier.jumpToStep(1);
    _initForm();
    state = state.success(data: customerId);
  }

  void onNavigatedBack(BuildContext context){
    ref.read(submission1RouteProvider).pop(context, output: const Submission1Output(result: "navigate back from submission"));
  }

  Future<Submission2Output?> onNavigatedToSubmission2(
    BuildContext context, {
    required GlobalKey<FormState> formKeySubmit,
  }) async {
    if (formKeySubmit.currentState!.validate()) {
      _validateDate();
    }

    // Only declare notifiers as local variable when it is used in only one method
    final provinceState = ref.read(provinceNotifierProvider);
    final districtState = ref.read(districtNotifierProvider);

    if (provinceState.data.selectedProvince == null ||
        districtState.data.selectedDistrict == null) return null;

    state = state.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(stateStatus: StateStatus.success);

    final input = Submission2Input(
      customerId: state.data,
      province: provinceState.data.selectedProvince!,
      district: districtState.data.selectedDistrict!,
    );

    _stepperNotifier.nextStep();
    return await ref
        .read(submission1RouteProvider)
        .navigateToSubmission2(context, input);
  }

  void _validateDate() {
    final startMonth = int.parse(startMonthController.text.toMonthNumber());
    final startYear = int.parse(startYearController.text);
    final endMonth = int.parse(endMonthController.text.toMonthNumber());
    final endYear = int.parse(endYearController.text);

    final startDate = DateTime(startYear, startMonth);
    final endDate = DateTime(endYear, endMonth);

    if (startDate.isAfter(endDate)) {
      _setVisibilityTillError(true);

      return;
    }

    _setVisibilityTillError(false);
    state = state.copyWith();
  }

  // Future<Submission3Output?> onNavigatedToSubmission3(BuildContext context) async {
  // final input = Submission3Input(formData: "Form Data from submission 1");
  // stepperNotifier.jumpToStep(3);
  // return await ref.read(submission1RouteProvider).navigateToSubmission3(context, input);
  // }

  void _initForm() {
    _setUpAddressSection();
    _setUpBranchSection();
  }

  void _setUpAddressSection() {
    final FLFormSection sectionBranch = FLFormSection(
      key: sectionAddressKey,
      factory: formFactory,
      title: 'Data Pilih Cabang',
      subTitle: 'Pilih cabang Kreditplus yang mengcover alamat domisili kamu',
      property: FLFormListProperty(
        separatorHeight: 16,
      ),
    );

    formFactory.addSection(
      section: sectionBranch,
      items: _getFieldSectionAddress(),
    );
  }

  void _setUpBranchSection() {
    final FLFormSection sectionAddress = FLFormSection(
      key: sectionBranchKey,
      factory: formFactory,
      title: "Alamat Tempat Tinggal",
      subTitle:
          "Masukkan alamat kamu sesuai informasi tempat tinggal terbaru kamu.",
      property: FLFormListProperty(
        separatorHeight: 16,
      ),
    );

    formFactory.addSection(
      section: sectionAddress,
      items: _getFieldSectionBranch(),
    );
  }

  List<FLFormItem> _getFieldSectionBranch() {
    return [
      const FLFormItem(
        key: textInputProvinceKey,
        sectionKey: sectionBranchKey,
        child: ProvinceDropdown(),
      ),
      const FLFormItem(
        key: textInputDistrictKey,
        sectionKey: sectionBranchKey,
        child: DistrictDropdown(),
      ),
    ];
  }

  List<FLFormItem> _getFieldSectionAddress() {
    return [
      FLFormItem(
        key: textInputAddressKey,
        sectionKey: sectionAddressKey,
        child: BuildAddressWidget(
          addressController: addressController,
        ),
      ),
      FLFormItem(
        key: textInputRtKey,
        sectionKey: sectionAddressKey,
        child: BuildRtRwWidget(
          rtController: rtController,
          rwController: rwController,
        ),
      ),
      FLFormItem(
        key: textInputStartDateKey,
        sectionKey: sectionAddressKey,
        child: BuildStartDateWidget(
          startMonthController: startMonthController,
          startYearController: startYearController,
          onSelectMonth: (month) {
            startMonthController.text = month;
            _setVisibilityEndDateForm();
          },
          onSelectYear: (year) {
            startYearController.text = year;
            _setVisibilityEndDateForm();
          },
        ),
      ),
      FLFormItem(
        key: textInputEndDateKey,
        sectionKey: sectionAddressKey,
        visible: false,
        child: BuildEndDateWidget(
          endMonthController: endMonthController,
          endYearController: endYearController,
          onSelectMonth: (month) {
            endMonthController.text = month;
          },
          onSelectYear: (year) {
            endYearController.text = year;
          },
        ),
      ),
      FLFormItem(
        key: tillErrorMessageKey,
        sectionKey: sectionAddressKey,
        visible: isShowTillError,
        child: const TillErrorMessage(
          tillErrorMessage: 'Tanggal Berakhir Sewa tidak valid',
        ),
      ),
    ];
  }

  void _setVisibilityEndDateForm() {
    formFactory.setVisibilityItem(
      itemKey: textInputEndDateKey,
      visible: startMonthController.text.isNotEmpty &&
          startYearController.text.isNotEmpty,
    );
  }

  void _setVisibilityTillError(bool value) {
    isShowTillError = value;

    formFactory.setVisibilityItem(
      itemKey: tillErrorMessageKey,
      visible: isShowTillError,
    );
  }
}

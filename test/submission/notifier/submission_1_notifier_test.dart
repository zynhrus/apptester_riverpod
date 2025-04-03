import 'package:app_riverpod/core/state/base_state.dart';
import 'package:app_riverpod/module/submission/common/district/state/district_data.dart';
import 'package:app_riverpod/module/submission/common/district/state/district_state.dart';
import 'package:app_riverpod/module/submission/common/province/state/province_data.dart';
import 'package:app_riverpod/module/submission/common/province/state/province_state.dart';
import 'package:app_riverpod/module/submission/common/stepper/stepper_notifier.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/constants/submission_1_key_constants.dart';
import 'package:app_riverpod/module/submission/submssion_1/notifier/submission_1_notifier.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/state/submission_1_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_test/riverpod_test.dart';

import '../dummy/submission_1_dummy.dart';
@GenerateMocks([
  Submission1Route,
  BuildContext,
])
import 'submission_1_notifier_test.mocks.dart';

class MockStepperNotifier extends AutoDisposeNotifier<int>
    with Mock
    implements StepperNotifier {}

void main() {
  late MockSubmission1Route mockSubmission1Route;
  late MockBuildContext mockContext;
  late MockStepperNotifier mockStepperNotifier;

  setUp(() {
    mockSubmission1Route = MockSubmission1Route();
    mockContext = MockBuildContext();
    mockStepperNotifier = MockStepperNotifier();
  });

  testNotifier(
    'PROVIDER Initial state SHOULD be empty',
    provider: submission1NotifierProvider,
    act: (notifier) => notifier.build(),
    expect: () => [],
  );

  testNotifier(
    'ACT onInitialized SHOULD update state with customerId and initialize form',
    provider: submission1NotifierProvider,
    overrides: [
      stepperNotifierProvider.overrideWith(() => mockStepperNotifier),
    ],
    setUp: () {
      when(mockStepperNotifier.jumpToStep(1)).thenReturn(null);
    },
    act: (notifier) => notifier.onInitialized(customerIdTest),
    expect: () =>
    [
      isA<Submission1State>()
          .having(
            (state) => state.stateStatus,
        'stateStatus',
        StateStatus.success,
      )
          .having(
            (state) => state.data,
        'data',
        customerIdTest,
      ),
    ],
    verify: (_) {
      verify(mockStepperNotifier.jumpToStep(1)).called(1);
    },
  );

  testNotifier(
    'ACT onNavigatedBack SHOULD pop route with result',
    provider: submission1NotifierProvider,
    overrides: [
      submission1RouteProvider.overrideWith((ref) => mockSubmission1Route),
    ],
    act: (notifier) => notifier.onNavigatedBack(mockContext),
    expect: () => [],
    verify: (_) {
      verify(mockSubmission1Route.pop(
        mockContext,
        output:
        const Submission1Output(result: "navigate back from submission"),
      )).called(1);
    },
  );

  group('onNavigatedToSubmission2 tests', () {
    testNotifier(
      'ACT onNavigatedToSubmission2 SHOULD return null when province or district is not selected',
      provider: submission1NotifierProvider,
      overrides: [
        submission1RouteProvider.overrideWith((ref) => mockSubmission1Route),
      ],
      setUp: () {
        when(mockSubmission1Route.navigateToSubmission2(mockContext, any))
            .thenAnswer(
              (_) async =>
          const Submission2Output(result: "success from submission 2"),
        );
      },
      act: (notifier) async {
        notifier.onInitialized(customerIdTest);

        notifier.provinceState = const ProvinceState(
          stateStatus: StateStatus.success,
          data: ProvinceData(
            province: [dummyProvince],
            selectedProvince: null,
          ),
        );

        notifier.districtState = const DistrictState(
          stateStatus: StateStatus.success,
          data: DistrictData(
            district: [dummyDistrict],
            selectedDistrict: null,
          ),
        );

        notifier.startMonthController.text = "Januari";
        notifier.startYearController.text = "2023";
        notifier.endMonthController.text = "Desember";
        notifier.endYearController.text = "2023";

        final result = await notifier.onNavigatedToSubmission2(mockContext);
        return result;
      },
      expect: () =>
      [
        // Only return Success onInitialized
        isA<Submission1State>().having(
              (state) => state.stateStatus,
          'stateStatus',
          StateStatus.success,
        ),
      ],
    );

    testNotifier(
      'ACT onNavigatedToSubmission2 SHOULD navigate to submission2 when all validations pass',
      provider: submission1NotifierProvider,
      overrides: [
        submission1RouteProvider.overrideWith((ref) => mockSubmission1Route),
        stepperNotifierProvider.overrideWith(() => mockStepperNotifier),
      ],
      setUp: () {
        when(mockStepperNotifier.nextStep()).thenReturn(null);
        when(mockSubmission1Route.navigateToSubmission2(
          mockContext,
          any,
        )).thenAnswer(
              (_) async =>
          const Submission2Output(result: "success from submission 2"),
        );
      },
      act: (notifier) async {
        // Setup state and controllers
        notifier.provinceState = const ProvinceState(
          stateStatus: StateStatus.success,
          data: ProvinceData(
            province: [dummyProvince],
            selectedProvince: dummyProvince,
          ),
        );

        notifier.districtState = const DistrictState(
          stateStatus: StateStatus.success,
          data: DistrictData(
            district: [dummyDistrict],
            selectedDistrict: dummyDistrict,
          ),
        );

        notifier.onInitialized(customerIdTest);

        // Setup valid date values
        notifier.startMonthController.text = "Januari";
        notifier.startYearController.text = "2023";
        notifier.endMonthController.text = "Desember";
        notifier.endYearController.text = "2023";

        final result = await notifier.onNavigatedToSubmission2(mockContext);
        return result;
      },
      wait: const Duration(seconds: 2),
      expect: () =>
      [
        // Success onInitialized
        isA<Submission1State>().having(
              (state) => state.stateStatus,
          'stateStatus',
          StateStatus.success,
        ),
        // Loading state onNavigatedToSubmission2
        isA<Submission1State>().having(
              (state) => state.stateStatus,
          'stateStatus',
          StateStatus.loading,
        ),
        // Success state onNavigatedToSubmission2
        isA<Submission1State>().having(
              (state) => state.stateStatus,
          'stateStatus',
          StateStatus.success,
        ),
      ],
      verify: (_) {
        verify(mockStepperNotifier.nextStep()).called(1);
        verify(mockSubmission1Route.navigateToSubmission2(
          mockContext,
          argThat(isA<Submission2Input>()
              .having(
                (input) => input.customerId,
            'customerId',
            customerIdTest,
          )
              .having(
                (input) => input.province,
            'province',
            dummyProvince,
          )
              .having(
                (input) => input.district,
            'district',
            dummyDistrict,
          )),
        )).called(1);
      },
    );

    testNotifier(
      'ACT _validateDate SHOULD set tillError visibility to true when start date is after end date',
      provider: submission1NotifierProvider,
      overrides: [
        submission1RouteProvider.overrideWith((ref) => mockSubmission1Route),
        stepperNotifierProvider.overrideWith(() => mockStepperNotifier),
      ],
      setUp: () {
        when(mockStepperNotifier.nextStep()).thenReturn(null);
        when(mockSubmission1Route.navigateToSubmission2(
          mockContext,
          any,
        )).thenAnswer(
              (_) async =>
          const Submission2Output(result: "success from submission 2"),
        );
      },
      act: (notifier) {
        // Setup state and controllers
        notifier.provinceState = const ProvinceState(
          stateStatus: StateStatus.success,
          data: ProvinceData(
            province: [dummyProvince],
            selectedProvince: dummyProvince,
          ),
        );

        notifier.districtState = const DistrictState(
          stateStatus: StateStatus.success,
          data: DistrictData(
            district: [dummyDistrict],
            selectedDistrict: dummyDistrict,
          ),
        );

        notifier.onInitialized(customerIdTest);

        // Setup invalid date values (start date after end date)
        notifier.startMonthController.text = "Desember";
        notifier.startYearController.text = "2023";
        notifier.endMonthController.text = "Januari";
        notifier.endYearController.text = "2023";

        return notifier.onNavigatedToSubmission2(mockContext);
      },
      expect: () =>
      [
        // Only Success onInitialized
        isA<Submission1State>().having(
              (state) => state.stateStatus,
          'stateStatus',
          StateStatus.success,
        ),
      ],
      verify: (notifier) {
        // Verify tillError visibility was set to true
        expect(notifier.isShowTillError, isTrue);
      },
    );
  });

  group('Form framework tests', () {
    testNotifier(
        'ACT onInitialized SHOULD set up 2 sections and 5 fields for address section and 2 fields for branch section',
        provider: submission1NotifierProvider,
        act: (notifier) {
          notifier.onInitialized(customerIdTest);
        },
        verify: (notifier) {
          expect(notifier.formFactory.getSectionCount(), 2);
          // Verify that the form factory was called with the correct number of fields
          expect(
            notifier.formFactory.getItemsCountBySection(
                sectionKey: sectionAddressKey),
            5,
          );
          expect(
            notifier.formFactory.getItemsCountBySection(
                sectionKey: sectionBranchKey),
            2,
          );

          // Verify that the visibility of the end date field was updated correctly
          expect(
            notifier.formFactory.getVisibilityItem(
              itemKey: textInputEndDateKey,
            ),
            isFalse,
          );
        });
  });

  testNotifier(
    'ACT dispose SHOULD dispose all controllers',
    provider: submission1NotifierProvider,
    act: (notifier) => notifier.dispose(),
    expect: () => [],
  );
}

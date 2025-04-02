import 'package:app_riverpod/core/state/base_state.dart';
import 'package:app_riverpod/module/submission/submssion_1/notifier/submission_1_notifier.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmf_dsl/fl_form_framework/fl_form_framework.dart';

class Submission1Screen extends ConsumerStatefulWidget {
  const Submission1Screen({
    super.key,
    required this.input,
  });

  final Submission1Input input;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Submission1ScreenState();
}

class _Submission1ScreenState extends ConsumerState<Submission1Screen> {
  final formKeySubmit = GlobalKey<FormState>();
  // Declare notifier as global variable when it is used in all over class
  late final Submission1Notifier submission1Notifier;

  @override
  void initState() {
    // Initialize notifier with customer id from screen input
    submission1Notifier = ref.read(submission1NotifierProvider.notifier);
    Future.microtask(() => submission1Notifier.onInitialized(widget.input.customerId));
    super.initState();
  }

  @override
  dispose() {
    submission1Notifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submission1State = ref.watch(submission1NotifierProvider);
    print("BUILD SUBMISSION SCREEN");
    return Stack(
      alignment: Alignment.center,
      children: [
        renderContent(),
        Visibility(
          visible: submission1State.stateStatus == StateStatus.loading,
          child: const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  Widget renderContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          renderCustomerId(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: FLFormRenderer(
              formKey: formKeySubmit,
              factory: submission1Notifier.formFactory,
              property: FLFormListProperty(
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              // Navigate using notifier method
              submission1Notifier.onNavigatedToSubmission2(
                context,
                formKeySubmit: formKeySubmit,
              );
            },
            child: const Text('Next'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navigate using notifier method
              submission1Notifier.onNavigatedBack(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // only rebuild when state.data (customer id) change
  Consumer renderCustomerId() {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        print("BUILD CUSTOMER ID TEXT");
        return Text("Customer id: ${ref.watch(submission1NotifierProvider.select((value) => value.data))}");
      },
    );
  }
}

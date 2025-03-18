import 'package:app_riverpod/module/submission/common/appbar.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input_output.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_input_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubmissionAppbar() as PreferredSizeWidget,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Submission 1"),
          Text(widget.input.customerId),
          ElevatedButton(
            onPressed: () {
              context.pop(const Submission1Output(result: "Submission navigate back"));
            },
            child: const Text('Close'),
          ),

          ElevatedButton(
            onPressed: () {
              ref.read(submission1RouteProvider).navigateToSubmission2(context, const Submission2Input(formData: "Form Data from submission 1"));
            },
            child: const Text('Next Submission 2'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(submission1RouteProvider).navigateToSubmission3(context, const Submission3Input(formData: "Form Data from submission 1"));
            },
            child: const Text('Next Submission 3'),
          )
        ],
      )
    );
  }
}
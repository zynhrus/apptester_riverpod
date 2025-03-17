import 'package:app_riverpod/submission/common/appbar.dart';
import 'package:app_riverpod/submission/submission_2/route/submission_2_route.dart';
import 'package:app_riverpod/submission/submission_2/route/suhmission_2_input_output.dart';
import 'package:app_riverpod/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:app_riverpod/submission/submssion_1/route/suhmission_1_input_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Submission2Screen extends ConsumerStatefulWidget {
  const Submission2Screen({
    super.key,
    required this.input,
  });

  final Submission2Input input;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Submission2ScreenState();
}

class _Submission2ScreenState extends ConsumerState<Submission2Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubmissionAppbar() as PreferredSizeWidget,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Submission 2"),
          Text(widget.input.formData),
          ElevatedButton(
            onPressed: () {
              context.pop(const Submission1Output(result: "navigate back from submission 2"));
            },
            child: const Text('back'),
          ),

          ElevatedButton(
            onPressed: () {
              ref.read(submission2RouteProvider).navigateToSubmission3(context, const Submission3Input(formData: "Form Data from submission 2"));
            },
            child: const Text('Next'),
          )
        ],
      )
    );
  }
}
import 'package:app_riverpod/module/submission/common/appbar.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Submission3Screen extends ConsumerStatefulWidget {
  const Submission3Screen({
    super.key,
    required this.input,
  });

  final Submission3Input input;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Submission3ScreenState();
}

class _Submission3ScreenState extends ConsumerState<Submission3Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubmissionAppbar() as PreferredSizeWidget,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Submission 3"),
          Text(widget.input.formData),
          ElevatedButton(
            onPressed: () {
              context.pop(const Submission3Output(result: "Submission 3 navigate back"));
            },
            child: const Text('back'),
          ),
        ],
      )
    );
  }
}
import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input_output.dart';
import 'package:app_riverpod/module/submission/submission_2/submission_2_screen.dart';
import 'package:app_riverpod/module/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_2_route.g.dart';

@riverpod
Submission2Route submission2Route(Submission2RouteRef ref) {
  return Submission2Route(ref: ref);
}

class Submission2Route extends BaseRoute<Submission2Input, Submission2Output> {
  Submission2Route({
    super.name = "submission_2",
    super.path = "/submission_2",
    required this.ref,
  });

  Submission2RouteRef ref;

  GoRoute route() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        return Submission2Screen(input: state.extra as Submission2Input);
      },
    );
  }

  // Available screen to navigate
  Future<Submission3Output?> navigateToSubmission3(BuildContext context, Submission3Input input) async {
    return ref.read(submission3RouteProvider).push(context, input);
  }
}
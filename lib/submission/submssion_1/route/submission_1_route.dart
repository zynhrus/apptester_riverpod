import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/submission/submission_2/route/submission_2_route.dart';
import 'package:app_riverpod/submission/submission_2/route/suhmission_2_input_output.dart';
import 'package:app_riverpod/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:app_riverpod/submission/submssion_1/route/suhmission_1_input_output.dart';
import 'package:app_riverpod/submission/submssion_1/submission_1_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_1_route.g.dart';

@riverpod
Submission1Route submission1Route(Submission1RouteRef ref) {
  return Submission1Route(ref: ref);
}

class Submission1Route extends BaseRoute<Submission1Input, Submission1Output> {
  Submission1Route({
    super.name = "submission_1",
    super.path = "/submission_1",
    required this.ref,
  });

  Submission1RouteRef ref;

  GoRoute route() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        return Submission1Screen(input: state.extra as Submission1Input);
      },
      routes: [
        ref.read(submission2RouteProvider).route(),
        ref.read(submission3RouteProvider).route(),
      ]
    );
  }

    // Available screen to navigate
  Future<Submission2Output?> navigateToSubmission2(BuildContext context, Submission2Input input) async {
    return ref.read(submission2RouteProvider).push(context, input);
  }

  Future<Submission3Output?> navigateToSubmission3(BuildContext context, Submission3Input input) async {
    return ref.read(submission3RouteProvider).push(context, input);
  }
}
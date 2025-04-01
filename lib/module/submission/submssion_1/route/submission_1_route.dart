import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/module/submission/submission_2/route/submission_2_route.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_input.dart';
import 'package:app_riverpod/module/submission/submission_2/route/suhmission_2_output.dart';
import 'package:app_riverpod/module/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_input.dart';
import 'package:app_riverpod/module/submission/submission_3/route/suhmission_3_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_input.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/submission_1_screen.dart';
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
    required Submission1RouteRef ref,
  }) : _ref = ref;

  final Submission1RouteRef _ref;

  GoRoute route(GlobalKey<NavigatorState> parentNavigatorKey) {
    return GoRoute(
      name: name,
      path: path,
      parentNavigatorKey: parentNavigatorKey,
      builder: (context, state) {
        return Submission1Screen(input: state.extra as Submission1Input);
      },
    );
  }

    // Available screen to navigate
  Future<Submission2Output?> navigateToSubmission2(BuildContext context, Submission2Input input) async {
    return _ref.read(submission2RouteProvider).push(context, input: input);
  }

  Future<Submission3Output?> navigateToSubmission3(BuildContext context, Submission3Input input) async {
    return _ref.read(submission3RouteProvider).push(context, input: input);
  }
}
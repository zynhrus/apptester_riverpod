import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/submission/submission_3/route/suhmission_3_input_output.dart';
import 'package:app_riverpod/submission/submission_3/submission_3_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_3_route.g.dart';

@riverpod
Submission3Route submission3Route(Submission3RouteRef ref) {
  return Submission3Route();
}

class Submission3Route extends BaseRoute<Submission3Input, Submission3Output> {
  Submission3Route({
    super.name = "submission_3",
    super.path = "/submission_3",
  });


  GoRoute route() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        return Submission3Screen(input: state.extra as Submission3Input);
      },
    );
  }
}
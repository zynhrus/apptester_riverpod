import 'package:app_riverpod/module/detail_transaction/route/detail_transaction_route.dart';
import 'package:app_riverpod/module/home/route/home_route.dart';
import 'package:app_riverpod/module/submission/submission_2/route/submission_2_route.dart';
import 'package:app_riverpod/module/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_manager.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ref.read(homeRouteProvider).path,
    routes: [
      ref.read(homeRouteProvider).route(),
      ref.read(detailTransactionRouteProvider).route(),
      ref.read(submission1RouteProvider).route(),
      ref.read(submission2RouteProvider).route(),
      ref.read(submission3RouteProvider).route(),
    ],
  );
}
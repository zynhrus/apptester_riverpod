import 'package:app_riverpod/module/home/route/home_route.dart';
import 'package:app_riverpod/module/submission/submission_2/route/submission_2_route.dart';
import 'package:app_riverpod/module/submission/submission_3/route/submission_3_route.dart';
import 'package:app_riverpod/module/submission/submission_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_manager.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ref.read(homeRouteProvider).path,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ref.read(homeRouteProvider).route(),
      ref.read(submissionRouteProvider).route(
        shellNavigatorKey: _shellNavigatorKey,
        shellRoutes: [
          ref.read(submission1RouteProvider).route(_shellNavigatorKey),
          ref.read(submission2RouteProvider).route(_shellNavigatorKey),
          ref.read(submission3RouteProvider).route(_shellNavigatorKey),
        ],
      ),
    ],
  );
}
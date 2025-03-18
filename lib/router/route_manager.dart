import 'package:app_riverpod/module/home/route/home_route.dart';
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
    ],
  );
}
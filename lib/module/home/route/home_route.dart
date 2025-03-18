import 'package:app_riverpod/core/router/base_route.dart';
import 'package:app_riverpod/module/detail_transaction/route/detail_transaction_input_output.dart';
import 'package:app_riverpod/module/detail_transaction/route/detail_transaction_route.dart';
import 'package:app_riverpod/module/home/home_screen.dart';
import 'package:app_riverpod/module/home/route/home_input_output.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/submission_1_route.dart';
import 'package:app_riverpod/module/submission/submssion_1/route/suhmission_1_input_output.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_route.g.dart';

// Instance provider of HomeRoute
@riverpod
HomeRoute homeRoute(HomeRouteRef ref) {
  return HomeRoute(ref: ref);
}

// Screen does not need input
class HomeRoute extends BaseRoute<Null, HomeOutput> {
  HomeRoute({
    super.name = "home",
    super.path = "/home",
    required this.ref,
  });

  HomeRouteRef ref;
  
  GoRoute route() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        // List of screen to navigate
        ref.read(detailTransactionRouteProvider).route(),
        ref.read(submission1RouteProvider).route(),
        // ref.read(profileRouteProvider).route(),
        // ....
        // ref.read(profileRouteProvider).route(),
      ]
    );
  }


  // Available screen to navigate
  Future<DetailTransactionOutput?> navigateToDetailTransaction(BuildContext context, DetailTransactionInput input) async {
    return ref.read(detailTransactionRouteProvider).push(context, input);
  }
  Future<Submission1Output?> navigatetoSubmission(BuildContext context, Submission1Input input) async {
    return ref.read(submission1RouteProvider).push(context, input);
  }
  // ....
  // Future<ProfileOutput?> navigatetoProfile(BuildContext context, ProfileInput input) async {
  //   return ref.read(profileRouteProvider).navigate(context, input);
  // }
}
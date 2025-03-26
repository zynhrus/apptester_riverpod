import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRoute<T, R> {
  BaseRoute({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
  
  Future<R?> push(BuildContext context, {T? input}) async {
    final result = await context.pushNamed<R>(
      name,
      extra: input,
    );
    return result;
  }

  void go(BuildContext context, {T? input}) async {
    context.goNamed(
      name,
      extra: input,
    );
  }

  void pop (BuildContext context, {R? output}) {
    context.pop(output);
  }
}
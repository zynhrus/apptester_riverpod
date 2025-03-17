import 'package:equatable/equatable.dart';

enum StateStatus { initial, initialLoading, loadMore, success, empty, failed }

abstract class BaseState<T, R> extends Equatable {
  const BaseState({
    required this.stateStatus,
    required this.data,
    this.failure,
  });
  
  final StateStatus stateStatus;
  final T data;
  final String? failure;

  R loading() => copyWith(stateStatus: StateStatus.initialLoading);

  R success({
    required T data,
  }) => copyWith(
    stateStatus: StateStatus.success,
    data: data,
  );

  R error({
    required String failure,
  }) => copyWith(
    stateStatus: StateStatus.failed,
    failure: failure,
  );

  R copyWith({
    StateStatus? stateStatus,
    T? data,
    String? failure,
  });

  @override
  List<Object?> get props => [
    stateStatus,
    data,
    failure,
  ];
}
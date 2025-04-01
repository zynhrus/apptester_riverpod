import 'package:equatable/equatable.dart';

class District extends Equatable {
  const District({
    required this.id,
    required this.provinceId,
    required this.name,
  });
  final int id;
  final int provinceId;
  final String name;

  factory District.empty() => const District(id: 0, provinceId: 0, name: "");

  @override
  List<Object?> get props => [id, provinceId, name];
}
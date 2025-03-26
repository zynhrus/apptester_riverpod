import 'package:equatable/equatable.dart';

class Province extends Equatable {
  const Province({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  factory Province.empty() => const Province(id: 0, name: "");

  @override
  List<Object?> get props => [id, name];
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.province,
    required this.district,
  });

  final String id;
  final String name;
  final String email;
  final String province;
  final String district;

  factory Customer.empty() => const Customer(id: "", name: "", email: "", province: "", district: "");
  
  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? province,
    String? district,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    province: province ?? this.province,
    district: district ?? this.district,
  );

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      province,
      district,
    ];
  }
}

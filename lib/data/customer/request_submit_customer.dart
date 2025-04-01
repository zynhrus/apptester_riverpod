import 'package:equatable/equatable.dart';

class RequestSubmitCustomer extends Equatable {
  const RequestSubmitCustomer({
    required this.name,
    required this.email,
    required this.province,
    required this.district,
  });

  final String name;
  final String email;
  final String province;
  final String district;

  factory RequestSubmitCustomer.fromJson(Map<String, dynamic> json) => RequestSubmitCustomer(
    name: json['name'],
    email: json['email'],
    province: json['province'],
    district: json['district'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'province': province,
    'district': district,
  };

  @override
  List<Object?> get props => [name, email, province, district];
}
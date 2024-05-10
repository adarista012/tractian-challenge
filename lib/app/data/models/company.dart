import 'package:equatable/equatable.dart';

class CompanyData extends Equatable {
  final String id;
  final String name;

  const CompanyData({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory CompanyData.fromJson(Map<String, dynamic> json) =>
      CompanyData(id: json['id'], name: json['name']);
}

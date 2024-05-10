import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  const Asset({
    required this.id,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.locationId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        parentId,
        sensorId,
        sensorType,
        status,
        gatewayId,
        locationId,
      ];

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"],
        name: json["name"],
        parentId: json["parentId"],
        sensorId: json["sensorId"],
        sensorType: json["sensorType"],
        status: json["status"],
        gatewayId: json["gatewayId"],
        locationId: json["locationId"],
      );
}

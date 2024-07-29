import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final String id;
  final String name;
  final Map<String, String> multilingualNames;
  final String description;
  final String districtId;
  final String districtName;
  final String stateId;
  final String stateName;
  final double latitude;
  final double longitude;

  City({
    required this.id,
    required this.name,
    required this.multilingualNames,
    required this.description,
    required this.districtId,
    required this.districtName,
    required this.stateId,
    required this.stateName,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      multilingualNames: Map<String, String>.from(json['multilingual_names'] ?? {}),
      description: json['description'] ?? '',
      districtId: json['district_id'] ?? '',
      districtName: json['district_name'] ?? '',
      stateId: json['state_id'] ?? '',
      stateName: json['state_name'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }
}


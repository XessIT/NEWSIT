// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: json['id'] as String,
      name: json['name'] as String,
      multilingualNames:
          Map<String, String>.from(json['multilingualNames'] as Map),
      description: json['description'] as String,
      districtId: json['districtId'] as String,
      districtName: json['districtName'] as String,
      stateId: json['stateId'] as String,
      stateName: json['stateName'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'multilingualNames': instance.multilingualNames,
      'description': instance.description,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'stateId': instance.stateId,
      'stateName': instance.stateName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

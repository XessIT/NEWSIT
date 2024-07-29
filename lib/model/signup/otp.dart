import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp.g.dart';

@JsonSerializable()
class OtpData extends Equatable {
  final String otp;

  const OtpData({required this.otp});

  factory OtpData.fromJson(Map<String, dynamic> json) => _$OtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpDataToJson(this);

  @override
  List<Object?> get props => [otp];
}
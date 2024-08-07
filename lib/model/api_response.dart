  import 'package:json_annotation/json_annotation.dart';

  part 'api_response.g.dart';

  @JsonSerializable(genericArgumentFactories: true)
  class ApiResponse<T> {
    final int status;
    final String message;
    final T data;

    ApiResponse({
      required this.status,
      required this.message,
      required this.data,
    });

    factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
      return _$ApiResponseFromJson(json, fromJsonT);
    }

    Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
      return _$ApiResponseToJson(this, toJsonT);
    }
  }

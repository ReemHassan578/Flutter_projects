import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final ErrorDetails? errorDetails;

  ApiErrorModel( {this.message,this.errorDetails});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  String getAllErrorMessages() {
    if (message != null && message!.isNotEmpty) {
      return message!;
    } else if (errorDetails != null) {
      return errorDetails!.errors.map((e) => e.message).join(', ');
    } else {
      return 'Unexpected error';
    }
  }
}

@JsonSerializable()
class ErrorDetails {
  final int code;
  final String message;
  final List<ErrorItem> errors;
  final String status;
  final List<DetailsItem> details;

  ErrorDetails(
      {required this.code,
      required this.message,
      required this.errors,
      required this.status,
      required this.details});
  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsFromJson(json);
}

@JsonSerializable()
class ErrorItem {
  final String message;
  final String domain;
  final String reason;

  ErrorItem(
      {required this.message, required this.domain, required this.reason});
  factory ErrorItem.fromJson(Map<String, dynamic> json) =>
      _$ErrorItemFromJson(json);
}

@JsonSerializable()
class DetailsItem {
  @JsonKey(name: '@type')
  final String type;
  final String reason;
  final String domain;
  @JsonKey(name: 'metadata')
  final String metaData;

  DetailsItem(
      {required this.type,
      required this.reason,
      required this.domain,
      required this.metaData});
  factory DetailsItem.fromJson(Map<String, dynamic> json) =>
      _$DetailsItemFromJson(json);
}

@JsonSerializable()
class MetaData {
  @JsonKey(name: 'quota_location')
  final String quotaLocation;

  final String service;
  @JsonKey(name: 'quota_metric')
  final String quotaMetric;
  final String consumer;
  @JsonKey(name: 'quota_limit_value')
  final String quotaLimitValue;
  @JsonKey(name: 'quota_limit')
  final String quotaLimit;

  MetaData(
      {required this.quotaLocation,
      required this.service,
      required this.quotaMetric,
      required this.consumer,
      required this.quotaLimitValue,
      required this.quotaLimit});

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}

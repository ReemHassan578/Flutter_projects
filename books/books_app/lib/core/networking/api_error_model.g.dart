// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      message: json['message'] as String?,
      errorDetails: json['errorDetails'] == null
          ? null
          : ErrorDetails.fromJson(json['errorDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorDetails': instance.errorDetails,
    };

ErrorDetails _$ErrorDetailsFromJson(Map<String, dynamic> json) => ErrorDetails(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ErrorItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => DetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorDetailsToJson(ErrorDetails instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors,
      'status': instance.status,
      'details': instance.details,
    };

ErrorItem _$ErrorItemFromJson(Map<String, dynamic> json) => ErrorItem(
      message: json['message'] as String,
      domain: json['domain'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$ErrorItemToJson(ErrorItem instance) => <String, dynamic>{
      'message': instance.message,
      'domain': instance.domain,
      'reason': instance.reason,
    };

DetailsItem _$DetailsItemFromJson(Map<String, dynamic> json) => DetailsItem(
      type: json['@type'] as String,
      reason: json['reason'] as String,
      domain: json['domain'] as String,
      metaData: json['metadata'] as String,
    );

Map<String, dynamic> _$DetailsItemToJson(DetailsItem instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'reason': instance.reason,
      'domain': instance.domain,
      'metadata': instance.metaData,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      quotaLocation: json['quota_location'] as String,
      service: json['service'] as String,
      quotaMetric: json['quota_metric'] as String,
      consumer: json['consumer'] as String,
      quotaLimitValue: json['quota_limit_value'] as String,
      quotaLimit: json['quota_limit'] as String,
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'quota_location': instance.quotaLocation,
      'service': instance.service,
      'quota_metric': instance.quotaMetric,
      'consumer': instance.consumer,
      'quota_limit_value': instance.quotaLimitValue,
      'quota_limit': instance.quotaLimit,
    };

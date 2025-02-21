// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_duration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentalDuration _$RentalDurationFromJson(Map<String, dynamic> json) =>
    RentalDuration(
      unit: json['unit'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$RentalDurationToJson(RentalDuration instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'count': instance.count,
    };

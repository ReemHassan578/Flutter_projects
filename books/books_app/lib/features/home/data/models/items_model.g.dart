// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      kind: json['kind'] as String,
      id: json['id'] as String,
      etag: json['etag'] as String,
      selfLink: json['selfLink'] as String,
      volumeInfo:
          VolumeInfoModel.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      saleInfo:
          SaleInfoModel.fromJson(json['saleInfo'] as Map<String, dynamic>),
      accessInfo:
          AccessInfoModel.fromJson(json['accessInfo'] as Map<String, dynamic>),
      searchInfo: json['searchInfo'] == null
          ? null
          : SearchInfoModel.fromJson(
              json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'accessInfo': instance.accessInfo,
      'searchInfo': instance.searchInfo,
    };

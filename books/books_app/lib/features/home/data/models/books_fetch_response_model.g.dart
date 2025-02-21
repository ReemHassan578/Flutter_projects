// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_fetch_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksFetchResponse _$BooksFetchResponseFromJson(Map<String, dynamic> json) =>
    BooksFetchResponse(
      kind: json['kind'] as String,
      totalItems: (json['totalItems'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksFetchResponseToJson(BooksFetchResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };

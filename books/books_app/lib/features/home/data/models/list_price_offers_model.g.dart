// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_price_offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPriceOffers _$ListPriceOffersFromJson(Map<String, dynamic> json) =>
    ListPriceOffers(
      amountInMicros: (json['amountInMicros'] as num).toInt(),
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$ListPriceOffersToJson(ListPriceOffers instance) =>
    <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode,
    };

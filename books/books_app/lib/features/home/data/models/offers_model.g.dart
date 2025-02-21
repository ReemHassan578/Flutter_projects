// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      finskyOfferType: (json['finskyOfferType'] as num).toInt(),
      listPriceOffers:
          ListPriceOffers.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice:
          ListPriceOffers.fromJson(json['retailPrice'] as Map<String, dynamic>),
      giftable: json['giftable'] as bool?,
      rentalDuration: json['rentalDuration'] == null
          ? null
          : RentalDuration.fromJson(
              json['rentalDuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'finskyOfferType': instance.finskyOfferType,
      'listPrice': instance.listPriceOffers,
      'retailPrice': instance.retailPrice,
      'giftable': instance.giftable,
      'rentalDuration': instance.rentalDuration,
    };

ListPriceOffers _$ListPriceOffersFromJson(Map<String, dynamic> json) =>
    ListPriceOffers(
      amountInMicros: (json['amountInMicros'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$ListPriceOffersToJson(ListPriceOffers instance) =>
    <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode,
    };

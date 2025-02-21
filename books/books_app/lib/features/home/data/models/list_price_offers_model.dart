import 'package:json_annotation/json_annotation.dart';
part 'list_price_offers_model.g.dart';

@JsonSerializable()
class ListPriceOffers {
  final int amountInMicros;
  final String currencyCode;

  ListPriceOffers({required this.amountInMicros, required this.currencyCode});

  factory ListPriceOffers.fromJson(Map<String, dynamic> json) =>
      _$ListPriceOffersFromJson(json);
}
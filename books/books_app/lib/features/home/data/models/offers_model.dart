
import 'package:json_annotation/json_annotation.dart';
import 'rental_duration_model.dart';
part 'offers_model.g.dart';

@JsonSerializable()
class Offers {
  final int finskyOfferType;
  @JsonKey(name: 'listPrice')
  final ListPriceOffers listPriceOffers;
  final ListPriceOffers retailPrice;
  final bool? giftable;
  final RentalDuration? rentalDuration;

  Offers(
      {required this.finskyOfferType,
      required this.listPriceOffers,
      required this.retailPrice,
       this.giftable,
       this.rentalDuration});
  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);
}

@JsonSerializable()
class ListPriceOffers {
  final double amountInMicros;
  final String currencyCode;

  ListPriceOffers({required this.amountInMicros, required this.currencyCode});
  factory ListPriceOffers.fromJson(Map<String, dynamic> json) =>
      _$ListPriceOffersFromJson(json);
}
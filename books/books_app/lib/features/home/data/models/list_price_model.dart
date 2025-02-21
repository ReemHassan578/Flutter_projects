import 'package:json_annotation/json_annotation.dart';
part 'list_price_model.g.dart';

@JsonSerializable()
class ListPrice {
  final double amount;
  final String currencyCode;

  ListPrice({required this.amount, required this.currencyCode});
  factory ListPrice.fromJson(Map<String, dynamic> json) =>
      _$ListPriceFromJson(json);
}
import 'package:json_annotation/json_annotation.dart';

import 'list_price_model.dart';
import 'offers_model.dart';
part 'sale_info_model.g.dart';


@JsonSerializable()
class SaleInfoModel {
  final String country;
  final String saleability;
  final bool isEbook;
  final ListPrice? listPrice;
  final ListPrice? retailPrice;
  final String? buyLink;
  final List<Offers>? offers;

  SaleInfoModel(
      {required this.country,
      required this.saleability,
      required this.isEbook,
       this.listPrice,
       this.retailPrice,
       this.buyLink,
       this.offers});

  factory SaleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SaleInfoModelFromJson(json);
}


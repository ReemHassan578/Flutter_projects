import 'package:json_annotation/json_annotation.dart';

import 'access_info_model.dart';
import 'sale_info_model.dart';
import 'search_info_model.dart';
import 'volume_info_model.dart';
part 'items_model.g.dart';


@JsonSerializable()
class Items {
  final String kind;
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfoModel volumeInfo;
  final SaleInfoModel saleInfo;
  final AccessInfoModel accessInfo;
  final SearchInfoModel searchInfo;

  Items(
      {required this.kind,
      required this.id,
      required this.etag,
      required this.selfLink,
      required this.volumeInfo,
      required this.saleInfo,
      required this.accessInfo,
      required this.searchInfo});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
}

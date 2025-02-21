

import 'package:json_annotation/json_annotation.dart';
part 'search_info_model.g.dart';


@JsonSerializable()
class SearchInfoModel {
  final String textSnippet;

  SearchInfoModel({required this.textSnippet});
  factory SearchInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoModelFromJson(json);
}

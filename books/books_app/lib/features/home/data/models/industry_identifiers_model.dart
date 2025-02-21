
import 'package:json_annotation/json_annotation.dart';
part 'industry_identifiers_model.g.dart';


@JsonSerializable()
class IndustryIdentifiers {
  final String type;
  final String identifier;

  IndustryIdentifiers({required this.type, required this.identifier});

  factory IndustryIdentifiers.fromJson(Map<String, dynamic> json) =>
      _$IndustryIdentifiersFromJson(json);
}

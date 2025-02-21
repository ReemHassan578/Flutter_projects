

import 'package:json_annotation/json_annotation.dart';

part 'epub_model.g.dart';


@JsonSerializable()
class Epub {
  final bool isAvailable;
  final String? acsTokenLink;

  Epub({required this.isAvailable,  this.acsTokenLink});
  factory Epub.fromJson(Map<String, dynamic> json) => _$EpubFromJson(json);
}